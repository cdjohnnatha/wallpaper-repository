# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(WallpaperPrice, type: :model) do
  let(:wallpaper) { create(:wallpaper) }
  let(:price) { Faker::Number.decimal(l_digits: 2) }

  it "should have a valid factory" do
    expect(build(:wallpaper)).to(be_valid)
  end

  context "validations" do
    it { should validate_presence_of(:price) }
  end

  context "attributes" do
    it "has price" do
      expect(build(:wallpaper_price, price: price)).to(have_attributes(price: price))
    end
  end

  context "relationships" do
    it { should belong_to(:wallpaper) }
  end
end
