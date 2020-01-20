# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Category, type: :model) do
  let(:name) { Faker::Superhero.name }

  it "should have a valid factory" do
    expect(build(:category)).to(be_valid)
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "attributes" do
    it "has filename" do
      expect(build(:category, name: name)).to(have_attributes(name: name))
    end
  end
end
