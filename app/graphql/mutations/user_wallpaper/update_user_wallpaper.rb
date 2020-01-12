# frozen_string_literal: true
module Mutations
  module UserWallpaper
    class UpdateUserWallpaper < BaseMutation
      argument :id, ID, required: true
      argument :description, String, required: false
      argument :price, Float, required: false
      argument :qty_available, Int, required: false
      argument :image, Types::CreateWallpaperInput, required: false

      field :wallpaper, Types::WallpaperType, null: false

      def resolve(args)
        inputs = {}
        inputs[:filename] = args[:filename] unless args[:filename].nil?
        inputs[:price] = args[:price] unless args[:price].nil?
        inputs[:qty_available] = args[:qty_available] unless args[:qty_available].nil?
        unless args[:image].nil?
          inputs[:file] = args[:image][:file] unless args[:image][:file].nil?
          inputs[:filename] = args[:image][:filename] unless  args[:image][:filename].nil?
        end
        if inputs.empty?
          return GraphQL::ExecutionError.new(I18n.t(:empty_attributes, model: :user, scope: [:errors, :messages]))
        end

        user_wallpaper = ::Wallpaper.find_by(id: args[:id])
        user_wallpaper.update!(inputs.to_h)

        if user_wallpaper.valid?
          { wallpaper: user_wallpaper }
        else
          GraphQL::ExecutionError.new(user_wallpaper.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
