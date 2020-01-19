# frozen_string_literal: true
module Mutations
  module Cart
    class DeleteCartItemMutation < BaseMutation
      argument :delete_cart_item_ids, [ID], required: true

      field :deleted_cart_items, [Types::Cart::CartItem::CartItemType], null: false
      field :total_amount, Float, null: false
      field :total_items, Int, null: false

      # raise something.inspect
      def resolve(args)
        check_authentication!
        deleted_cart_items = []
        undeleted_cart_items = []
        cart = ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
        args[:delete_cart_item_ids].each do |id|
          ::Cart.transaction do
            cart_item = cart.cart_items.find(id)
            if cart_item
              authorize_destroy?(CartItemPolicy, cart_item)
              deleted_cart_item = cart_item.destroy!
              wallpaper = ::Wallpaper.find(deleted_cart_item.wallpaper_id)
              wallpaper.qty_available += deleted_cart_item.quantity
              wallpaper.save!
              if wallpaper.valid?
                deleted_cart_items.push(deleted_cart_item)
              end
            end
          rescue ActiveRecord::ActiveRecordError => e
            error_item = {}
            error_item[:node] = { id: id }
            error_item[:message] = e.message
            undeleted_cart_items.push(error_item)
          end
        end

        cart.update_total
        if cart.valid?
          build_errors(undeleted_cart_items) unless undeleted_cart_items.empty?
          {
            deleted_cart_items: deleted_cart_items,
            total_amount: cart.total_amount,
            total_items: cart.total_items,
          }
        else
          GraphQL::ExecutionError.new(cart.errors.full_messages)
        end
      end

      def build_errors(unsaved)
        unsaved.map do |cart_item|
          context.add_error(
            GraphQL::ExecutionError.new(
              cart_item[:message],
              extensions: { code: 'UNDELETED_CART_ITEMS', attributes: cart_item[:node] }
            )
          )
        end
      end
    end
  end
end
