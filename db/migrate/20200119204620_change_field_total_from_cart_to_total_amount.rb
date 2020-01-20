class ChangeFieldTotalFromCartToTotalAmount < ActiveRecord::Migration[6.0]
  def change
    rename_column :carts, :total, :total_amount
  end
end
