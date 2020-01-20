# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Role, type: :model) do
  let(:name) { Faker::Superhero.name }

  it "should have a valid factory" do
    expect(build(:role)).to(be_valid)
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "attributes" do
    it "has filename" do
      expect(build(:role, name: name)).to(have_attributes(name: name))
    end
  end
end
