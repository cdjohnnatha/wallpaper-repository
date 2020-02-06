require 'rails_helper'

RSpec.describe("Orders", type: :request) do
  let(:user) { create(:user, :with_order) }
  let(:order) { create(:order) }
  let(:order_item_fragment) {
    %|
      orderItems {
        createdAt
        discounts
        id
        quantity
        updatedAt
        wallpaper {
          description
          filename
          id
          qtyAvailable
          seller  {
            email
            firstName
            fullName
            id
            lastName
          }
          wallpaperPrice {
            id
            price
          }
          wallpaperUrl
        }
      }
    |
  }
  let(:order_paginated_query) {
    %|
      {
        orders(pagination: {
          currentPage: 0,
          rowsPerPage: 1
        }) {
          paginate {
            currentPage
            rowsPerPage
            totalPages
          }
          values {
            id
            totalAmount
            totalItems
            paymentMethod
            status
            #{order_item_fragment}
          }
        }
      }
    |
  }
  def order_query(orderId)
    %|
      {
        order(orderId:#{orderId}) {
          id
          #{order_item_fragment}
          paymentMethod
          status
          totalAmount
          totalItems
        } 
      }
    |
  end
  describe "orders" do
    context "authenticated" do
      before(:each) do
        post '/graphql', params: { query: order_paginated_query }, headers: authenticated_header(user)
        @order = graphql_response["orders"]
      end

      it_behaves_like "an order fields", "debit_card", "created" do
        let(:order) { @order['values'].first }
      end

      it_behaves_like "a wallpaper fields" do
        let(:wallpaperFields) { @order["values"].first["orderItems"].first["wallpaper"] }
      end

      it_behaves_like "a pagination", "orders"
      it_behaves_like "a success query/mutation"
    end

    context "single order" do
      before(:each) do
        post '/graphql', params: { query: order_query(user.orders.first.id) }, headers: authenticated_header(user)
        @order = graphql_response["order"]
      end

      it_behaves_like "an order fields", "debit_card", "created" do
        let(:order) { @order }
      end

      it_behaves_like "a wallpaper fields" do
        let(:wallpaperFields) { @order["orderItems"].first["wallpaper"] }
      end

      it_behaves_like "a success query/mutation"
    end
    context "single order from another user" do
      before do
        post '/graphql', params: { query: order_query(order.id) }, headers: authenticated_header(user)
      end

      it_behaves_like "a common error"
    end
  end
  context "not authenticated" do
    before(:each) do
      post '/graphql', params: { query: order_paginated_query }
    end

    it_behaves_like "a common error"
    it_behaves_like "not authenticated"
  end

  context "single order" do
    before(:each) do
      post '/graphql', params: { query: order_query(user.orders.first.id) }
    end

    it_behaves_like "a common error"
    it_behaves_like "not authenticated"
  end
  context "single order from another user" do
    before do
      post '/graphql', params: { query: order_query(order.id) }
    end

    it_behaves_like "a common error"
    it_behaves_like "not authenticated"
  end
end
