# frozen_string_literal: true
module Types
  module UserWallpaper
    class WallpaperPaginatedType < Types::BaseObject
      field :paginate, Types::PaginationType, null: false
      field :values, [Types::UserWallpaper::WallpaperType], null: false
    end
  end
end
