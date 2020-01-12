# frozen_string_literal: true
require 'carrierwave/orm/activerecord'

class Wallpaper < ApplicationRecord
  mount_uploader :file, ImageUploader

  validates :filename, presence: true
  validates :file, presence: true
  validates :path, presence: true
  validates :qty_available, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
end
