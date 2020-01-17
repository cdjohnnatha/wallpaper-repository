class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.float :discounts
      t.belongs_to(:order)
      t.belongs_to(:wallpaper_id)
      t.belongs_to(:wallpaper_price_id)
      t.timestamps
    end
  end
end
