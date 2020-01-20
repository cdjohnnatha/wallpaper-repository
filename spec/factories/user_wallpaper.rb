# frozen_string_literal: true
require "faker"

FactoryBot.define do
  factory :wallpaper do
    filename { Faker::Superhero.name }
    qty_available { 1 }
    path { Faker::File.file_name(dir: 'uploads/user') }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/shopify.png'), 'image/png') }

    transient do
      prices { 1 }
    end

    after(:create) do |wallpaper, evaluator|
      create_list(:wallpaper_price, evaluator.prices, wallpaper: wallpaper)
    end
    # relationships
    user
  end
end
