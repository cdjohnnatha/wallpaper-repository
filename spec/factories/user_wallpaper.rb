# frozen_string_literal: true
require "faker"

FactoryBot.define do
  factory :wallpaper do
    filename { Faker::Superhero.name }
    price {  Faker::Number.decimal(l_digits: 2) }
    qty_available { 1 }
    path { Faker::File.file_name(dir: 'uploads/user') }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/shopify.png'), 'image/png') }

    # relationships
    user
  end
end
