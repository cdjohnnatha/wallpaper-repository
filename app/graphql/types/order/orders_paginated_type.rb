module Types
  module Order
    class OrdersPaginatedType < Types::BaseObject
      field :paginate, Types::PaginationType, null: false
      field :values, [OrderType], null: false
    end
  end
end