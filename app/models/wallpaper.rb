# frozen_string_literal: true
require 'carrierwave/orm/activerecord'

class Wallpaper < ApplicationRecord
  acts_as_paranoid
  mount_uploader :file, ImageUploader

  validates :filename, presence: true
  validates :file, presence: true
  validates :path, presence: true
  validates :qty_available, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :wallpaper_prices

  accepts_nested_attributes_for :wallpaper_prices

  def wallpaper_price
    wallpaper_prices.last(1).first
  end
end
