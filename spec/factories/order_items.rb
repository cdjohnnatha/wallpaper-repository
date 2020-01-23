# frozen_string_literal: true
FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    discounts { 0.0 }

    transient do
      wallpaperCreate { create(:wallpaper) }
    end
    wallpaper { wallpaperCreate }
    wallpaper_price { wallpaperCreate.wallpaper_price }
    order
  end
end
