# frozen_string_literal: true
module Types
  module Cart
    class CartType < Types::BaseObject
      field :id, ID, null: false
      field :total, Float, null: false
      field :discounts, Float, null: false
      field :state, String, null: false
      field :cart_items, Types::Cart::CartItem::CartItemPaginatedType, null: false
      field :created_at, String, null: false
      field :updated_at, String, null: false

      field :email, String, null: false
    end
  end
end
