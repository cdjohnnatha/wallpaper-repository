module Types
  module Enum
    class PaymentEnum < Types::Enum::BaseEnum
      value "credit_card", "Enum related to credit_card payment method"
      value "debit_card", "Enum related to debit_card payment method"
    end 
  end
end