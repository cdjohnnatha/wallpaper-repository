class AddDeletedAtToWallpapers < ActiveRecord::Migration[6.0]
  def change
    add_column :wallpapers, :deleted_at, :datetime
    add_index :wallpapers, :deleted_at
  end
end
