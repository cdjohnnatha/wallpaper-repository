# frozen_string_literal: true
module Mutations
  module UserWallpaper
    class DeleteUserWallpaperMutation < BaseMutation
      argument :id, ID, required: true

      field :wallpaper, Types::WallpaperType, null: false

      def resolve(args)
        check_authentication!
        user_wallpaper = ::Wallpaper.find(args[:id])
        authorize_destroy?(UserWallpaperPolicy, user_wallpaper)

        user_wallpaper = user_wallpaper.destroy

        if user_wallpaper
          { wallpaper: user_wallpaper }
        else
          GraphQL::ExecutionError.new(user.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
