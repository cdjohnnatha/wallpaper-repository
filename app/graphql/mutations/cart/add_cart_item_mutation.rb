# frozen_string_literal: true
module Mutations
  module Cart
    class AddCartItemMutation < BaseMutation
      argument :cart_items, [Types::Inputs::Cart::CartItemInput], required: true

      field :cart, Types::Cart::CartType, null: false

      def resolve(args)
        check_authentication!
        cart = ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
        if cart.valid?
          values = cart.cart_items.create!(Hash[args[:cart_items]])
          raise values.inspect
          if cart_items.valid?
            { cart: cart }
          else
            GraphQL::ExecutionError.new(cart_items.errors.full_messages)
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
