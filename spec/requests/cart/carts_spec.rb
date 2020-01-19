require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let(:user) { create(:user, :with_cart) }
  let(:cartQuery) {
    %|
      {
        cart {
          cartItems {
            createdAt
            id
            updatedAt
            wallpaper {
              description
              filename
              id
              qtyAvailable
              seller {
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
          createdAt
          discounts
          id
          status
          totalAmount
          totalItems
          updatedAt
        } 
      }
    |
  }
  describe "A cart" do
    context "authenticated" do
      before(:each) do
        post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
        @cart = graphql_response["cart"]
      end

      it_behaves_like "a cart fields" do
        let(:cart) { @cart }
      end

      it_behaves_like "a wallpaper fields" do
        let(:wallpaperFields) { @cart["cartItems"].first["wallpaper"] }
      end

      it_behaves_like "a success query/mutation"
    end
    context "not authenticated" do
      before(:each) { post '/graphql', params: { query: cartQuery } }

      it_behaves_like "a common error"
      it_behaves_like "not authenticated"
    end
  end
end
