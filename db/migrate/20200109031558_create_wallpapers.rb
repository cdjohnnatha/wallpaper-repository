class CreateWallpapers < ActiveRecord::Migration[6.0]
  def change
    create_table :wallpapers do |t|
      t.string :filename
      t.string :path
      t.belongs_to :user

      t.timestamps
    end
  end
end
