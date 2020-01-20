# frozen_string_literal: true
module Queries
  module Wallpapers
    class Wallpapers < Types::BaseObject
      description "It will get a list of wallpapers and their owners from database"
      argument :pagination, Types::Inputs::PaginationInputType, required: true

      field :wallpapers, [Types::UserWallpaper::WallpaperType], null: false
      field :pagination, [Types::PaginationType], null: true

      def resolve(args)
        wallpapers = Wallpaper.page(args[:current_page]).per(args[:rows_per_page])
        # raise wallpapers.inspect
        # pagination = {}
        # pagination[]
        { wallpapers: wallpapers }
      end
    end
  end
end
