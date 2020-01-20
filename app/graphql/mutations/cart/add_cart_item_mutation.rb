# frozen_string_literal: true
module Mutations
  module Cart
    class AddCartItemMutation < BaseMutation
      argument :cart_items, [Types::Inputs::Cart::CartItemInput], required: true

      field :cart_items, [Types::Cart::CartItem::CartItemType], null: true
      field :total_amount, Float, null: false
      field :total_items, Int, null: false

      def resolve(args)
        check_authentication!
        cart = ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
        saved_items = []
        unsaved = []
        if cart.valid?
          args[:cart_items].each do |item|
            ::CartItem.transaction do
              cart_item = cart.cart_items.create!(item.to_h)
              wallpaper = ::Wallpaper.find(cart_item.wallpaper_id)
              wallpaper.wallpaper_prices.find(item.wallpaper_price_id)
              qty_available = wallpaper.qty_available
              if cart_item.quantity <= qty_available && (qty_available - item.quantity) >= 0
                wallpaper.qty_available -= item.quantity
                wallpaper.save!
                if wallpaper.valid? && cart_item.valid?
                  saved_items.push(cart_item)
                end
              else
                raise I18n.t(
                  :unavailable_wallpaper_quantity,
                  id: item.wallpaper_id,
                  quantity: wallpaper.qty_available,
                  scope: [:errors, :messages]
                )
              end
            rescue StandardError => e
              error_item = {}
              error_item[:node] = item.to_h
              error_item[:message] = e.message
              unsaved.push(error_item)
            end
          end
          cart.update_total
          if cart.valid?
            build_errors(unsaved) unless unsaved.empty?
            return {
              cart_items: saved_items,
              total_amount: cart.total_amount,
              total_items: cart.total_items
            }
          end
        end

        GraphQL::ExecutionError.new(cart.errors.full_messages)
      end

      def build_errors(unsaved)
        unsaved.map do |cart_item|
          context.add_error(
            GraphQL::ExecutionError.new(
              cart_item[:message],
              extensions: { code: 'UNSAVED_CART_ITEMS', attributes: cart_item[:node] }
            )
          )
        end
      end
    end
  end
end
