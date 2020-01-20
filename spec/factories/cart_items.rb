# frozen_string_literal: true
require "faker"
FactoryBot.define do
  factory :cart_item do
    quantity { 1 }

    transient do
      wallpaperCreate { create(:wallpaper) }
    end
    wallpaper { wallpaperCreate }
    wallpaper_price { wallpaperCreate.wallpaper_price }
    cart
  end
end
