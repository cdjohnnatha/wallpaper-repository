# frozen_string_literal: true
class WallpaperPrice < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :wallpaper
end
