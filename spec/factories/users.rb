# frozen_string_literal: true
require "faker"

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "123456789" }

    trait :with_admin_role do
      after(:create) do |user|
        user.roles << create(:role, :admin)
      end
    end
  end
end
