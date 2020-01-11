require 'carrierwave/orm/activerecord'

class Wallpaper < ApplicationRecord
  mount_uploader :file, ImageUploader

  belongs_to :user
end
