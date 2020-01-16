# frozen_string_literal: true
class Cart < ApplicationRecord
  acts_as_paranoid
  enum status: [:created, :purchased]

  has_many :cart_items
end
