# frozen_string_literal: true
module Types
  module Cart
    module CartItem
      class CartItemPaginatedType < Types::BaseObject
        field :paginate, Types::PaginationType, null: true
        field :values, [Types::Cart::CartItem::CartItemType], null: true
      end
    end
  end
end
