# frozen_string_literal: true
module Mutations
  module UserWallpaper
    class CreateUserWallpaperMutation < BaseMutation
      argument :image, Types::CreateWallpaperInput, required: true
      argument :price, Float, required: true
      argument :quantity, Int, required: true
      argument :user_id, ID, required: true

      field :wallpaper, Types::WallpaperType, null: true
      field :errors, [String], null: true

      def resolve(args)
        args[:path] = '/uploads/user/' + args[:user_id]
        args[:file] = args[:image][:file]
        args[:filename] = args[:image][:filename]
        result = ::Wallpaper.create(args.except(:image))
        if result.valid?
          { wallpaper: result, errors: [] }
        else
          { wallpaper: nil, errors: result.errors.full_messages }
        end
      end
    end
  end
end
