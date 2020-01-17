# frozen_string_literal: true
class AddQuantityToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column(:cart_items, :quantity, :integer)
  end
end
