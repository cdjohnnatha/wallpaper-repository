# frozen_string_literal: true
module Types
  module Enum
    class OrderStatusEnum < Types::Enum::BaseEnum
      value "created", "Enum related to order creation"
      value "waiting_payment_authorization", "Enum related to waiting a payment authorization"
      value "payed", "Enum related to payed status"
    end
  end
end
