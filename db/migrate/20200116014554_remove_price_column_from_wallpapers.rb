# frozen_string_literal: true
class RemovePriceColumnFromWallpapers < ActiveRecord::Migration[6.0]
  def change
    remove_column(:wallpapers, :price)
  end
end
