# frozen_string_literal: true
FactoryBot.define do
  factory :order do

    status { :created }
    payment_method { :debit_card }

    trait :with_purchased_status do
      status { :purchased }
    end

    cart
    user
  end
end
