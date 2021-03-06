# frozen_string_literal: true
module Types
  module Cart
    module CartItem
      class CartItemType < Types::BaseObject
        field :id, ID, null: false
        field :wallpaper, Types::UserWallpaper::WallpaperType, null: false
        field :created_at, String, null: false
        field :updated_at, String, null: false
      end
    end
  end
end
