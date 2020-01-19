# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Order, type: :model) do
  it "should have a valid factory" do
    expect(build(:order)).to(be_valid)
  end

  context "validations" do
    it { should validate_presence_of(:total_amount) }
    it { should validate_presence_of(:payment_method) }
  end

  context "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:cart) }
    it { should have_many(:order_items) }
  end
end
