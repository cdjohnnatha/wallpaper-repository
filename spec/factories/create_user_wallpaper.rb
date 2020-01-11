# frozen_string_literal: true
require "faker"

FactoryBot.define do
  factory :wallpaper do
    filename { Faker::Superhero.name }
    price {  Faker::Number.decimal(l_digits: 2) }
    quantity { 1 }

    user
  end
end
