# frozen_string_literal: true
module Types
  module UserWallpaper
    class WallpaperType < Types::BaseObject
      field :id, ID, null: false
      field :filename, String, null: false
      field :description, String, null: true
      field :wallpaper_price, Types::UserWallpaper::WallpaperPriceType, null: false
      field :qty_available, Int, null: false
      field :seller, Types::UserType, null: false
      def seller
        object.user
      end
      field :wallpaper_url, String, null: false
      def wallpaper_url
        object.file.to_s
      end
    end
  end
end
