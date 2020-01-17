# frozen_string_literal: true
module Mutations
  module Cart
    class DeleteCartItemMutation < BaseMutation
      argument :cart_item_id, [ID], required: true

      field :deleted_cart_items, [Types::Cart::CartItem::CartItemType], null: false

      def resolve(args)
        check_authentication!
        deleted_items = args[:cart_item_id].map do |item|
          item = ::CartItem.find(item)
          authorize_destroy?(CartItemPolicy, item)
          item.destroy
        end
        cart = ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
        cart.update_total
        if cart.valid?
          { deleted_cart_items: deleted_items }
        end
      end
    end
  end
end
