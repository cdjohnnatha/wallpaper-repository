# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(CartItem, type: :model) do
  it "should have a valid factory" do
    expect(build(:cart_item)).to(be_valid)
  end

  context "relationships" do
    it { should belong_to(:cart) }
    it { should belong_to(:wallpaper) }
    it { should belong_to(:wallpaper_price) }
  end
end
