# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(OrderItem, type: :model) do

  context "validations" do
    it { should validate_presence_of(:discounts) }
  end

  context "relationships" do
    it { should belong_to(:order) }
    it { should belong_to(:wallpaper) }
    it { should belong_to(:wallpaper_price) }
  end
end
