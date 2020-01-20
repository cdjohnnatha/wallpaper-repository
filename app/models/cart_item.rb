# frozen_string_literal: true
class CartItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :wallpaper
  belongs_to :wallpaper_price
  belongs_to :cart
end
