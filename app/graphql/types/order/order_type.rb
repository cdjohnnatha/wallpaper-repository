module Types
  module Order
    class OrderType < Types::BaseObject
      field :id, ID, null: false
      field :payment_method, Types::Enum::PaymentEnum, null: false
      field :status, Types::Enum::OrderStatusEnum, null: false
      field :order_items, [Types::Order::OrderItem::OrderItemType], null: false
    end
  end
end