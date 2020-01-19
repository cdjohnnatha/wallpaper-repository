require 'rails_helper'

RSpec.describe("AddCartItems", type: :request) do
  let(:user) { create(:user) }
  let(:wallpaper) { create_list(:wallpaper, 2) }
  let(:cart_item) { attributes_for(:cart_item) }
  let(:cart_item_fragment) {
    %|
      {
        totalAmount
        totalItems
        cartItems {
          createdAt
          id
          updatedAt
          wallpaper {
            description
            filename
            id
            qtyAvailable
            wallpaperUrl
            wallpaperPrice {
              id
              price
            }
          }
        }
      }
    |
  }
  let(:mutation) do
    %|
      mutation {
        addCartItems(input: {
          cartItems: [
            {
              wallpaperId: #{wallpaper[0].id}
              wallpaperPriceId: #{wallpaper[0].wallpaper_price.id}
              quantity: #{cart_item[:quantity]}
            }
          ]
        }) #{cart_item_fragment}
      }
    |
  end

  describe "Add cart item" do
    before { create_list(:wallpaper, 3) }

    context "authenticated" do
      let(:cartQuery) {
        %|
          {
            cart{
              total
            }
          }
        |
      }
      before do
        post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
        @result_total = graphql_response["cart"]
      end
      context "add one item" do
        before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

        it_behaves_like "a cart item fields" do
          let(:cart) { graphql_response["addCartItems"] }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { graphql_response["addCartItems"]["cartItems"].first["wallpaper"] }
        end

        it_behaves_like "a success query/mutation"

        it "should have 1 elements" do
          expect(graphql_response["addCartItems"]["cartItems"].length).to(eq(1))
        end
        it "should be added the item amount to total" do
          added_to_total = @result_total["total"] + graphql_response["addCartItems"]["totalAmount"]
          expect(added_to_total).to(eq(graphql_response["addCartItems"]["totalAmount"]))
        end
      end

      context "add multiple items" do
        let(:mutation) do
          %|
            mutation {
              addCartItems(input: {
                cartItems: [
                  {
                    wallpaperId: #{wallpaper[0].id}
                    wallpaperPriceId: #{wallpaper[0].wallpaper_price.id}
                    quantity: #{cart_item[:quantity]}
                  }
                  {
                    wallpaperId: #{wallpaper[1].id}
                    wallpaperPriceId: #{wallpaper[1].wallpaper_price.id}
                    quantity: #{cart_item[:quantity]}
                  }
                ]
              }) #{cart_item_fragment}
            }
          |
        end
        before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

        it_behaves_like "a cart item fields" do
          let(:cart) { graphql_response["addCartItems"] }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { graphql_response["addCartItems"]["cartItems"].first["wallpaper"] }
        end
        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { graphql_response["addCartItems"]["cartItems"][1]["wallpaper"] }
        end

        it_behaves_like "a success query/mutation"

        it "should have 1 elements" do
          expect(graphql_response["addCartItems"]["cartItems"].length).to(eq(2))
        end
        it "should be added the items amount to total" do
          added_to_total = @result_total["total"] + graphql_response["addCartItems"]["totalAmount"]
          expect(added_to_total).to(eq(graphql_response["addCartItems"]["totalAmount"]))
        end
      end

      context "add multiple items, with one not available" do
        let(:mutation) do
          %|
            mutation {
              addCartItems(input: {
                cartItems: [
                  {
                    wallpaperId: #{wallpaper.first.id}
                    wallpaperPriceId: #{wallpaper.first.wallpaper_price.id}
                    quantity: #{cart_item[:quantity]}
                  }
                  {
                    wallpaperId: #{wallpaper.first.id}
                    wallpaperPriceId: #{wallpaper.first.wallpaper_price.id}
                    quantity: #{cart_item[:quantity]}
                  }
                ]
              }) #{cart_item_fragment}
            }
          |
        end
        before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

        it_behaves_like "a common error"
      end
    end

    context "unauthorized" do

      context "add one item" do
        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end

      context "add multiple items" do
        let(:mutation) do
          %|
            mutation {
              addCartItems(input: {
                cartItems: [
                  {
                    wallpaperId: #{wallpaper[0].id}
                    wallpaperPriceId: #{wallpaper[0].wallpaper_price.id}
                    quantity: #{cart_item[:quantity]}
                  }
                  {
                    wallpaperId: #{wallpaper[1].id}
                    wallpaperPriceId: #{wallpaper[1].wallpaper_price.id}
                    quantity: #{cart_item[:quantity]}
                  }
                ]
              }) #{cart_item_fragment}
            }
          |
        end
        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
    end
  end
end
