# frozen_string_literal: true

Role.create!([{ name: :admin }, { name: :client }])

user_claudio = User.create!(
  first_name: 'Claudio',
  last_name: 'Lourenco',
  email: 'cdjohnnatha@gmail.com',
  password: '123456789',
)

user_client = User.create!(
  first_name: 'John',
  last_name: 'Doe',
  email: 'johndoe@gmail.com',
  password: '123456789',
)

Wallpaper.create!([
  {
    filename: 'Shopify',
    file: Pathname.new(Rails.root.join("public/images/shopify_512.png")).open,
    path: '/wallpapers/files/',
    description: "Shopify image",
    price: 0.00,
    qty_available: 0,
    user_id: user_claudio.id,
  },
])

user_claudio.add_role(:admin)
user_client.add_role(:client)
