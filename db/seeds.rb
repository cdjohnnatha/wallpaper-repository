# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create([
  {
    first_name: 'Claudio',
    last_name: 'Lourenco',
    email: 'cdjohnnatha@gmail.com',
    password: '123456789',
  },
])
Wallpaper.create!([
  {
    filename: 'Shopify',
    file: Pathname.new(Rails.root.join("public/images/shopify_512.png")).open,
    path: '/wallpapers/files/',
    description: "Shopify image",
    price: 0.00,
    qty_available: 0,
    user_id: user[0].id,
  },
])
