class OrderItem < ApplicationRecord
  acts_as_paranoid

  validates :discounts, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :order
  belongs_to :wallpaper
  belongs_to :wallpaper_price
end
