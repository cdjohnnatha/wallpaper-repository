# frozen_string_literal: true
require "faker"

Role.create_with(name: :admin).find_or_create_by(name: :admin)
Role.create_with(name: :client).find_or_create_by(name: :client)

user_claudio = User.create_with(
  first_name: 'Claudio',
  last_name: 'Lourenco',
  email: 'cdjohnnatha@gmail.com',
  password: '123456789',
).find_or_create_by!(email: 'cdjohnnatha@gmail.com')

user_client = User.create_with(
  first_name: 'John',
  last_name: 'Doe',
  email: 'johndoe@gmail.com',
  password: '123456789',
).find_or_create_by!(email: 'johndoe@gmail.com')

Wallpaper.create_with(
  filename: 'Shopify',
  file: Pathname.new(Rails.root.join("public/images/shopify_512.png")).open,
  path: '/wallpapers/files/',
  description: "Shopify image",
  qty_available: 0,
  user_id: user_claudio.id,
  wallpaper_prices_attributes: [price: 0]
).find_or_create_by(filename: 'Shopify')

user_claudio.add_role(:admin)
user_client.add_role(:client)

Category.create_with(name: 'Shopify').find_or_create_by(name: 'Shopify')
2.times do |_i|
  Category.create(name: Faker::DcComics.hero)
end
