# frozen_string_literal: true
class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.float(:discounts)
      t.float(:quantity)
      t.belongs_to(:order)
      t.belongs_to(:wallpaper)
      t.belongs_to(:wallpaper_price)
      t.timestamps
      t.datetime(:deleted_at)
    end
  end
end
