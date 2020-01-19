# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(User, type: :model) do
  it "should have a valid factory" do
    expect(build(:user)).to(be_valid)
  end

  context "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password) }
  end

  context "attributes" do
    it "has email" do
      expect(build(:user, email: "x@y.z")).to(have_attributes(email: "x@y.z"))
    end
    it "has first_name" do
      expect(build(:user, first_name: "testeFirstName")).to(have_attributes(first_name: "testeFirstName"))
    end
    it "has last_name" do
      expect(build(:user, last_name: "testeLastName")).to(have_attributes(last_name: "testeLastName"))
    end
    it "has password" do
      expect(build(:user, password: "password123")).to(have_attributes(password: "password123"))
    end
  end

  context "relationships" do
    it { should have_many(:carts) }
    it { should have_many(:wallpapers) }
    it { should have_many(:orders) }
  end
end
