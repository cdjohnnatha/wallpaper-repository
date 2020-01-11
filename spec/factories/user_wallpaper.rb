# frozen_string_literal: true
require "faker"

FactoryBot.define do
  factory :wallpaper do
    filename { Faker::Superhero.name }
    price {  Faker::Number.decimal(l_digits: 2) }
    qty_available { 1 }
    path { Faker::File.file_name(dir: 'uploads/user') }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/shopify.png'), 'image/png') }

    after :create do |brand|
      wallpaper.update_column(:file,  Time.now.to_i.to_s + ".png")
    end

    # relationships
    user
  end
end
