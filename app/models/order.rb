class Order < ApplicationRecord
  acts_as_paranoid
  enum status: [:created, :waiting_payment_authorization, :payed]
  enum payment_method: [:debit_card, :credit_card]

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  belongs_to :cart
  has_many :order_items
end
