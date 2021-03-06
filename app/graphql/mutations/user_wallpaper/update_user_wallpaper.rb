# frozen_string_literal: true
require 'json'

module Mutations
  module UserWallpaper
    class UpdateUserWallpaper < BaseMutation
      argument :id, ID, required: true
      argument :description, String, required: false
      argument :price, Float, required: false
      argument :qty_available, Int, required: false
      argument :image, Types::Inputs::UserWallpaper::CreateWallpaperInput, required: false

      field :wallpaper, Types::UserWallpaper::WallpaperType, null: false

      def resolve(args)
        check_authentication!
        inputs = {}
        inputs[:filename] = args[:filename] unless args[:filename].nil?
        inputs[:wallpaper_prices_attributes] = [price: args[:price]] unless args[:price].nil?
        inputs[:qty_available] = args[:qty_available] unless args[:qty_available].nil?
        inputs[:description] = args[:description] unless args[:description].nil?

        unless args[:image].nil?
          inputs[:file] = args[:image][:file] unless args[:image][:file].nil?
          inputs[:filename] = args[:image][:filename] unless args[:image][:filename].nil?
        end

        if inputs.empty?
          return GraphQL::ExecutionError.new(I18n.t(:empty_attributes, model: :wallpaper, scope: [:errors, :messages]))
        end

        user_wallpaper = ::Wallpaper.find(args[:id])
        authorize_update?(UserWallpaperPolicy, user_wallpaper)
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
