# frozen_string_literal: true
require "faker"
FactoryBot.define do
  factory :cart do
    user
    total_amount { 0.0 }

    transient do
      items { 3 }
    end

    after(:create) do |cart, evaluator|
      create_list(:cart_item, evaluator.items, cart: cart)
    end
  end
end
