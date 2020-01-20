require 'rails_helper'

RSpec.describe("AddCartItems", type: :request) do
  let(:user) { create(:user, :with_cart) }
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

  let(:cartQuery) { '{ cart{ totalAmount totalItems } }' }

  describe "Add cart item" do
    before { create_list(:wallpaper, 3) }
    context "authenticated" do
      before(:each) do
        post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
        @cart_before_add_item = graphql_response["cart"]
      end
      context "add one item" do
        before do
          post '/graphql', params: { query: mutation }, headers: authenticated_header(user)
          @added_item = graphql_response["addCartItems"]
        end

        it_behaves_like "a cart fields" do
          let(:cart) { @added_item }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @added_item["cartItems"].first["wallpaper"] }
        end

        it_behaves_like "a success query/mutation"

        before do
          post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
          @cart_after_add_item = graphql_response["cart"]
        end

        it "should be added the item amount to total" do
          updated_total_amount = @cart_before_add_item["totalAmount"] + wallpaper[0].wallpaper_price.price
          expect(updated_total_amount.round(2)).to(eq(@cart_after_add_item["totalAmount"].round(2)))
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
        before do
          post '/graphql', params: { query: mutation }, headers: authenticated_header(user)
          @added_item = graphql_response["addCartItems"]
        end

        it_behaves_like "a cart fields" do
          let(:cart) { @added_item }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @added_item["cartItems"].first["wallpaper"] }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @added_item["cartItems"][1]["wallpaper"] }
        end

        it_behaves_like "a success query/mutation"

        before do
          post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
          @cart_after_add_item = graphql_response["cart"]
        end

        it_behaves_like "a success query/mutation"

        it "should be added the item amount to total" do
          total_amount_added_items = @added_item['cartItems'].sum do |e|
            e["wallpaper"]["wallpaperPrice"]["price"].to_f
          end
          updated_total_amount = @cart_before_add_item["totalAmount"] + total_amount_added_items
          expect(updated_total_amount.round(2)).to(eq(@cart_after_add_item["totalAmount"].round(2)))
        end
      end

      context "add multiple items, with one unavailable" do
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
      context "authenticated" do
        before(:each) do
          post '/graphql', params: { query: cartQuery }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"

        context "add one item" do
          before do
            post '/graphql', params: { query: mutation }
            @added_item = graphql_response["addCartItems"]
          end
  
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
  
        context "add multiple items, with one unavailable" do
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
          before { post '/graphql', params: { query: mutation } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end
      end
    end
  end
end
