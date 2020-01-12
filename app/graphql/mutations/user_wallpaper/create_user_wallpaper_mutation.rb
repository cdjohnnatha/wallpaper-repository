# frozen_string_literal: true
module Mutations
  module UserWallpaper
    class CreateUserWallpaperMutation < BaseMutation
      argument :image, Types::CreateWallpaperInput, required: true
      argument :description, String, required: false
      argument :price, Float, required: true
      argument :qty_available, Int, required: true
      argument :user_id, ID, required: true

      field :wallpaper, Types::WallpaperType, null: true

      def resolve(args)
        args[:path] = '/wallpapers/files/'
        args[:file] = args[:image][:file]
        args[:filename] = args[:image][:filename]
        result = ::Wallpaper.create(args.except(:image))
        if result.valid?
          { wallpaper: result }
        else
          GraphQL::ExecutionError.new(result.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
