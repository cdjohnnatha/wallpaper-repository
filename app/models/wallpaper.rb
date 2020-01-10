require 'carrierwave/orm/activerecord'

class Wallpaper < ApplicationRecord
  mount_uploader :path, ImageUploader

  belongs_to :user
end
