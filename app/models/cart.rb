# frozen_string_literal: true
class Cart < ApplicationRecord
  acts_as_paranoid
  enum status: [:created, :purchased]

  has_many :cart_items
  belongs_to :user

  def update_total
    self.total = cart_items.joins(:wallpaper_price).sum(:price)
    save
  end
end
