# frozen_string_literal: true
module Mutations
  module UserWallpaper
    class CreateUserWallpaperMutation < BaseMutation
      argument :image, Types::CreateWallpaperInput, required: true
      argument :description, String, required: false
      argument :price, Float, required: true
      argument :qty_available, Int, required: true

      field :wallpaper, Types::WallpaperType, null: true

      def resolve(args)
        check_authentication!
        user = context[:current_user]
        args[:path] = '/wallpapers/files/'
        args[:file] = args[:image][:file]
        args[:filename] = args[:image][:filename]
        args[:user_id] = user.id
        args[:wallpaper_prices_attributes] = [price: args[:price]]
        result = ::Wallpaper.create(args.except(:image, :price))
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
