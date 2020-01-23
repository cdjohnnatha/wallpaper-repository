# frozen_string_literal: true
FactoryBot.define do
  factory :order do

    status { :created }
    payment_method { "debit_card" }

    trait :with_purchased_status do
      status { :purchased }
    end

    transient do
      items { 3 }
    end

    after(:create) do |order, evaluator|
      create_list(:order_item, evaluator.items, order: order)
    end

    cart
    user
  end
end
