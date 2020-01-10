# frozen_string_literal: true
module Mutations
  module UserWallpaper
    class CreateUserWallpaperMutation < BaseMutation
      argument :filename, String, required: true
      argument :path, ApolloUploadServer::Upload, required: false
      argument :user_id, ID, required: true

      field :wallpaper, Types::WallpaperType, null: true
      field :errors, [String], null: true

      def resolve(args)
        result = ::Wallpaper.create(args)
        if result.valid?
          { wallpaper: result, errors: [] }
        else
          { wallpaper: nil, errors: result.errors.full_messages }
        end
      end
    end
  end
end
