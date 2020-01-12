# frozen_string_literal: true
require 'rails_helper'
require "faker"

RSpec.describe(Wallpaper, type: :model) do
  let(:filename) { Faker::Superhero.name }
  let(:file) { Time.now.to_i.to_s + ".jpg" }
  let(:user) { create(:user) }
  let(:path) { 'uploads/user/' + user.id.to_s }
  let(:price) { Faker::Number.decimal(l_digits: 2) }

  it "should have a valid factory" do
    expect(build(:wallpaper)).to(be_valid)
  end

  context "validations" do
    it { should validate_presence_of(:filename) }
    it { should validate_presence_of(:file) }
    it { should validate_presence_of(:path) }
    it { should validate_presence_of(:qty_available) }
    it { should validate_presence_of(:price) }
  end

  context "attributes" do
    it "has filename" do
      expect(build(:wallpaper, filename: filename)).to(have_attributes(filename: filename))
    end
    it "has path" do
      expect(build(:wallpaper, path: path)).to(have_attributes(path: path))
    end
    it "has qty_available" do
      expect(build(:wallpaper, qty_available: 1)).to(have_attributes(qty_available: 1))
    end
    it "has price" do
      expect(build(:wallpaper, price: price)).to(have_attributes(price: price))
    end
  end

  context "relationships" do
    it { should belong_to(:user) }
    #   it { should have_many(:comments) }
  end
end
