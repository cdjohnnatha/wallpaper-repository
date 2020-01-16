# frozen_string_literal: true
class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.float(:total, default: 0.0)
      t.integer(:status, default: 0)
      t.float(:discounts, default: 0.0)
      t.datetime(:deleted_at)
      t.belongs_to(:user)

      t.timestamps
    end
  end
end
