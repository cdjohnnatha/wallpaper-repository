module Types
  module Enum
    class CartStatusEnum < Types::Enum::BaseEnum
      value "created", "A cart state to represent when a cart is created and/or it as a list of items to be purchased"
      value "purchased", "A cart state to represent when a cart it was purchased"
    end 
  end
end