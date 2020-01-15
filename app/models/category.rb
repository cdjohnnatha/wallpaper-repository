# frozen_string_literal: true
class Category < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
end
