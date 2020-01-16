# frozen_string_literal: true
class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to(:wallpaper)
      t.belongs_to(:wallpaper_price)
      t.belongs_to(:cart)
      t.datetime(:deleted_at)

      t.timestamps
    end
  end
end
