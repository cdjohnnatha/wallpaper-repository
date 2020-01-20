# frozen_string_literal: true
module Types
  module Inputs
    module Cart
      class CartItemInput < Types::BaseInputObject
        argument :wallpaper_id, Int, required: true
        argument :wallpaper_price_id, Int, required: true
        argument :quantity, Int, required: true
      end
    end
  end
end
