require "faker"

FactoryBot.define do
  factory :wallpaper_price do
    price { Faker::Number.decimal(l_digits: 2) }
    # wallpaper
  end
end
