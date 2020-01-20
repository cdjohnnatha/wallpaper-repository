# frozen_string_literal: true
FactoryBot.define do
  factory :role do
    name { Faker::Name.name }

    trait :client do
      name { "client" }
    end

    trait :admin do
      name { "admin" }
    end
  end
end
