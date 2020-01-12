# frozen_string_literal: true
class CreateWallpapers < ActiveRecord::Migration[6.0]
  def change
    create_table :wallpapers do |t|
      t.string(:filename)
      t.text(:description)
      t.string(:file)
      t.string(:path)
      t.float(:price)
      t.integer(:qty_available)
      t.belongs_to(:user)

      t.timestamps
    end
  end
end
