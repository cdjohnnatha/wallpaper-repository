# frozen_string_literal: true
RSpec.shared_examples("an order fields") do |payment_method, status|
  it "should return an order fields" do
    expect(order).to(have_key("paymentMethod"))
    expect(order).to(have_key("status"))
    expect(order).to(have_key("orderItems"))
    expect(order).to(have_key("totalAmount"))
    expect(order).to(have_key("totalItems"))
    expect(order).to(have_key("id"))
    expect(order['paymentMethod']).to(eq(payment_method))
    expect(order['status']).to(eq(status))
  end
end

RSpec.shared_examples("an order paginated fields") do |payment_method, status|
  it "should return an order fields" do
    expect(order).to(have_key("values"))
    expect(order).to(have_key("paginate"))
  end
end

RSpec.shared_examples("an order item fields") do
  it "should return an order fields" do
    expect(order).to(have_key("createdAt"))
    expect(order).to(have_key("updatedAt"))
    expect(order).to(have_key("discounts"))
    expect(order).to(have_key("id"))
    expect(order).to(have_key("quantity"))
    expect(order).to(have_key("wallpaper"))
  end
end