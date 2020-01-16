# frozen_string_literal: true
class CreateWallpaperPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :wallpaper_prices do |t|
      t.float(:price)
      t.belongs_to(:wallpaper)

      t.timestamps
    end
  end
end
