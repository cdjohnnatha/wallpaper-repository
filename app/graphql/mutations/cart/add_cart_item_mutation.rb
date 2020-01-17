# frozen_string_literal: true
module Mutations
  module Cart
    class AddCartItemMutation < BaseMutation
      argument :cart_items, [Types::Inputs::Cart::CartItemInput], required: true

      field :cart_items, [Types::Cart::CartItem::CartItemType], null: false

      def resolve(args)
        check_authentication!
        cart = ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
        if cart.valid?
          cart_items = args[:cart_items].map do |item|
            item = cart.cart_items.build(item.to_h)
            wallpaper = item.wallpaper
            qty_available = wallpaper.qty_available
            raise wallpaper.inspect
            if item.quantity <= qty_available & item.quantity - qty_available >= 0
              wallpaper.qty_available -= item.quantity
              raise item.wallpaper.inspect
              item
            end
          end

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
