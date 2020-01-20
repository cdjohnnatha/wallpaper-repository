module Types
  module Order
    module OrderItem
      class OrderItemType < BaseObject
        field :id, ID, null: false
        field :discounts, Float, null: false
        field :quantity, Int, null: false
        field :wallpaper, Types::UserWallpaper::WallpaperType, null: false
        field :created_at, String, null: false
        field :updated_at, String, null: false
      end
    end
  end
end