# frozen_string_literal: true
module Types
  module Cart
    class CartType < Types::BaseObject
      field :id, ID, null: false
      field :total_amount, Float, null: false
      field :total_items, Int, null: false
      field :discounts, Float, null: false
      field :status, Types::Enum::CartStatusEnum, null: false
      field :created_at, String, null: false
      field :updated_at, String, null: false

      field :cart_items, [Types::Cart::CartItem::CartItemType], null: false
    end
  end
end
