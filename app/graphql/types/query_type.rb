# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    field :list_users, [Types::UserType], null: false,
      description: "An example field added by the generator"
    def list_users
      User.all
    end

    field :wallpapers, [Types::WallpaperType], null: false,
      description: "It will list all wallpapers and their owners"
    def wallpapers
      Wallpaper.all
    end

    field :wallpaper, Types::WallpaperType, "It will filter and show an image by id", null: false do
      argument :wallpaper_id, ID, required: true
    end
    def wallpaper(wallpaper_id:)
      Wallpaper.find(wallpaper_id)
    end
  end
end
