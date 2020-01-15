class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string(:name)
      t.datetime(:deleted_at, null: true)
      t.timestamps

      add_index :categories, :deleted_at
    end
  end
end
