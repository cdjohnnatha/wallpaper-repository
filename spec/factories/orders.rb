# frozen_string_literal: true
FactoryBot.define do
  factory :order do

    status { :created }

    trait :with_purchased_status do
      status { :purchased }
    end

    cart
    user
  end
end
