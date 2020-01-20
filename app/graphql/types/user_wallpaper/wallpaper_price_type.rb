# frozen_string_literal: true
module Types
  module UserWallpaper
    class WallpaperPriceType < Types::BaseObject
      field :id, ID, null: false
      field :price, Float, null: false
    end
  end
end
