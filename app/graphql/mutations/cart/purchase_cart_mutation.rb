module Mutations
  module Cart
    class PurchaseCartMutation < BaseMutation
      argument :payment_type, Types::Enum::PaymentEnum, required: true

      field :payment_type, Float, null: false
      def resolve(args)
        {}
      end
    end
  end
end
