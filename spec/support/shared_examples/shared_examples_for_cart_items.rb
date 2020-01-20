# frozen_string_literal: true
RSpec.shared_examples("a cart fields") do
  it "should return cart item fields" do
    expect(cart).to(have_key("totalAmount"))
    expect(cart).to(have_key("totalItems"))
  end
end

RSpec.shared_examples("a cart items fields") do |item_element|
  it "should return cart item fields" do
    expect(cart[item_element]).to(be_an_instance_of(Array))
    expect(cart[item_element].first).to(have_key("id"))
    expect(cart[item_element].first).to(have_key("createdAt"))
    expect(cart[item_element].first).to(have_key("updatedAt"))
    expect(cart[item_element].first).to(have_key("wallpaper"))
  end
end
