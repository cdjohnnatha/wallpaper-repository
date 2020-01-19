# frozen_string_literal: true
module Mutations
  module Cart
    class PurchaseCartMutation < BaseMutation
      argument :payment_method, Types::Enum::PaymentEnum, required: true

      field :order, Float, null: false
      def resolve(args)
        check_authentication!

        cart = ::Cart.where(user_id: context[:current_user], status: :created).first

        return GraphQL::ExecutionError.new('Empty cart') unless !cart.cart_items.any?

        order = ::Order.where(
          payment_method: args[:payment_method],
          status: :created,
          cart_id: cart.id,
          user_id: context[:current_user].id,
        ).first_or_create!
        if order.valid?
          order_items = cart.cart_items.map do |item|
            order.order_items.new(
              wallpaper_id: item.wallpaper_id,
              wallpaper_price_id: item.wallpaper_price_id,
              quantity: item.quantity,
              discounts: 0.0
            )
          end
          if order_items.all?(&:valid?) && order_items.all?(&:save)
            cart.status = "purchased"
            cart.save
            order.sum_and_save_total_amount
            { order: 0.0 }
          end
        end
      end
    end
  end
end
