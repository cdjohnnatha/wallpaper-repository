# frozen_string_literal: true
class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer(:payment_method)
      t.integer(:status)
      t.float(:total_amount, default: 0.0)
      t.belongs_to(:user)
      t.belongs_to(:cart)
      t.timestamps
      t.datetime(:deleted_at)
    end
  end
end
