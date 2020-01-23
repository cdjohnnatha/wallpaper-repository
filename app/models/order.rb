# frozen_string_literal: true
class Order < ApplicationRecord
  acts_as_paranoid
  enum status: [:created, :waiting_payment_authorization, :payed]
  enum payment_method: [:debit_card, :credit_card]

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_method, presence: true

  belongs_to :user
  belongs_to :cart
  has_many :order_items

  def sum_and_save_total_amount
    self.total_amount = order_items.joins(:wallpaper_price).sum(:price)
    save
  end

  def total_items
    self.order_items.count
  end
end
