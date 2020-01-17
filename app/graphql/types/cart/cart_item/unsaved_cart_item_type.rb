# frozen_string_literal: true
module Types
  module Cart
    module CartItem
      class UnsavedCartItemType < Types::BaseObject
        field :wallpaper_id, Int, null: false
        field :wallpaper_price_id, Int, null: false
        field :quantity, Int, null: false
        field :error_message, String, null: false
      end
    end
  end
end
