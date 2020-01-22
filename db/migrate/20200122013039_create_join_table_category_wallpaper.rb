class CreateJoinTableCategoryWallpaper < ActiveRecord::Migration[6.0]
  def change
    create_join_table :categories, :wallpapers do |t|
      # t.index [:category_id, :wallpaper_id]
      # t.index [:wallpaper_id, :category_id]
    end
  end
end
