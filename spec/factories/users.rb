# frozen_string_literal: true
require "faker"

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "123456789" }

    transient do
      cart_count { 1 }
    end

    trait :with_admin_role do
      after(:create) do |user|
        user.roles << create(:role, :admin)
      end
    end

    trait :with_cart do
      after(:create) do |user|
        user.carts << create(:cart, user: user)
        user.carts.first.update_total
      end
    end

    trait :with_order do
      after(:create) do |user|
        user.orders << create(:order, user: user)
      end
    end
  end
end
