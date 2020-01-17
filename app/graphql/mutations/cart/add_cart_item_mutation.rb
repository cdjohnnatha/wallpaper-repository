# frozen_string_literal: true
module Mutations
  module Cart
    class AddCartItemMutation < BaseMutation
      argument :cart_items, [Types::Inputs::Cart::CartItemInput], required: true

      field :saved_items, [Types::Cart::CartItem::CartItemType], null: false
      field :not_saved_items, [Types::Cart::CartItem::UnsavedCartItemType], null: false

      def resolve(args)
        check_authentication!
        cart = ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
        saved_items = Array.new
        unsaved_items = Array.new
        if cart.valid?
          args[:cart_items].each do |item|
            ::CartItem.transaction do
              cartItem = cart.cart_items.create!(item.to_h)
              wallpaper = ::Wallpaper.find(cartItem.wallpaper_id)
              qty_available = wallpaper.qty_available
              if cartItem.quantity <= qty_available && (qty_available - item.quantity) >= 0
                wallpaper.qty_available -= item.quantity
                wallpaper.save!
                if wallpaper.valid? && cartItem.valid?
                  saved_items.push(cartItem)
                end
              else
                raise I18n.t(
                  :unavailable_wallpaper_quantity,
                  id: item.wallpaper_id,
                  quantity: wallpaper.qty_available,
                  scope: [:errors, :messages]
                )
              end
            rescue Exception => e
              raise e.message.inspect
              item[:error_message] = e.message
              unsaved_items.push(item)
            end
          end
          raise unsaved_items.inspect

          if cart_items.all?(&:valid?) && cart_items.all?(&:save)
            cart.update_total
            if cart.valid?
              { cart_items: cart_items }
            end
          else
            GraphQL::ExecutionError.new(cart.errors.full_messages)
          end
        else
          GraphQL::ExecutionError.new(cart.errors.full_messages)
        end
        rescue ActiveRecord::ActiveRecordError => invalid
          GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
