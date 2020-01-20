require 'rails_helper'

RSpec.describe("DeleteCartItems", type: :request) do
  let(:user) { create(:user, :with_cart) }
  let(:random_user) { create(:user, :with_cart) }
  let(:cart_item_fragment) {
    %|
      {
        totalAmount
        totalItems
        deletedCartItems {
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
  let(:cartQuery) { '{ cart{ totalAmount totalItems } }' }
  def mutation(ids)
    %|
      mutation {
        deleteCartItem(input: {
          deleteCartItemIds: #{ids}
        }) #{cart_item_fragment}
      }
    |
  end

  describe "Remove cart item" do
    context "authenticated" do
      before do
        @total_before_delete = user.carts.first.total_amount
        @total_items_delete = user.carts.first.cart_items.length
      end
      context "delete one item" do
        before do 
          post '/graphql',
          params: { query: mutation([user.carts.first.cart_items.first.id]) },
          headers: authenticated_header(user)
          @deleted_item = graphql_response['deleteCartItem']
        end

        it_behaves_like "a cart fields" do
          let(:cart) { @deleted_item }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @deleted_item["deletedCartItems"].first["wallpaper"] }
        end

        it_behaves_like "a success query/mutation"

        before do
          post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
          @cart_after_delete = graphql_response['cart']
        end

        it "should have the amount of total_cart_before_delete - item_to_delete_price" do
          total_after_delete = @total_before_delete - @deleted_item['deletedCartItems'].first["wallpaper"]["wallpaperPrice"]["price"]
          expect(total_after_delete.round(2)).to(eq(@cart_after_delete['totalAmount'].round(2)))
        end
      end

      context "delete multiple items" do
        before do 
          post '/graphql',
          params: { query: mutation([user.carts.first.cart_items[0].id, user.carts.first.cart_items[1].id]) },
          headers: authenticated_header(user)
          @deleted_item = graphql_response['deleteCartItem']
        end

        it_behaves_like "a cart fields" do
          let(:cart) { @deleted_item }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @deleted_item["deletedCartItems"].first["wallpaper"] }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @deleted_item["deletedCartItems"][1]["wallpaper"] }
        end

        it_behaves_like "a success query/mutation"

        before do
          post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
          @cart_after_delete = graphql_response['cart']
        end

        it "should have the amount of total_cart_before_delete - item_to_delete_price" do
          total_items_to_delete = @deleted_item['deletedCartItems'][0]["wallpaper"]["wallpaperPrice"]["price"] + @deleted_item['deletedCartItems'][1]["wallpaper"]["wallpaperPrice"]["price"]
          total_after_delete = @total_before_delete - total_items_to_delete
          expect(total_after_delete.round(2)).to(eq(@cart_after_delete['totalAmount'].round(2)))
        end
      end
      context "delete same item twice" do
        before do 
          post '/graphql',
          params: { query: mutation([user.carts.first.cart_items.first.id, user.carts.first.cart_items.first.id]) },
          headers: authenticated_header(user)
          @deleted_item = graphql_response['deleteCartItem']
        end

        it_behaves_like "a common error"
      end

      context "delete multiple items, with one duplicated" do
        before do 
          post '/graphql',
          params: { query: mutation([user.carts.first.cart_items[0].id, user.carts.first.cart_items[0].id, user.carts.first.cart_items[1].id]) },
          headers: authenticated_header(user)
          @deleted_item = graphql_response['deleteCartItem']
        end

        it_behaves_like "a cart fields" do
          let(:cart) { @deleted_item }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @deleted_item["deletedCartItems"].first["wallpaper"] }
        end

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { @deleted_item["deletedCartItems"][1]["wallpaper"] }
        end


        before do
          post '/graphql', params: { query: cartQuery }, headers: authenticated_header(user)
          @cart_after_delete = graphql_response['cart']
        end

        it "should not include the total amount of repeated item" do
          total_items_to_delete = @deleted_item['deletedCartItems'].sum do |e|
            e["wallpaper"]["wallpaperPrice"]["price"].to_f
          end
          total_items_to_delete += user.carts.first.cart_items.first.wallpaper_price.price
          total_after_delete = @total_before_delete - total_items_to_delete
          expect(total_after_delete.round(2)).not_to(eq(@cart_after_delete['totalAmount'].round(2)))
        end
      end

      context "delete items from other person" do
        before do 
          post '/graphql',
          params: { query: mutation([
            random_user.carts.first.cart_items[0].id,
            random_user.carts.first.cart_items[1].id,
          ]) },
          headers: authenticated_header(user)
        end

        it_behaves_like "a common error"
      end
    end

    context "not authenticated" do
      before do
        @total_before_delete = user.carts.first.total_amount
        @total_items_delete = user.carts.first.cart_items.length
      end
      context "delete one item" do
        before { post '/graphql', params: { query: mutation([user.carts.first.cart_items.first.id]) } }

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end

      context "delete multiple items" do
        before do 
          post '/graphql',
          params: { query: mutation([user.carts.first.cart_items[0].id, user.carts.first.cart_items[1].id]) }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
      context "delete same item twice" do
        before do 
          post '/graphql',
          params: { query: mutation([user.carts.first.cart_items.first.id, user.carts.first.cart_items.first.id]) }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end

      context "delete multiple items, with one duplicated" do
        before do 
          post '/graphql',
          params: { query: mutation([
            user.carts.first.cart_items[0].id,
            user.carts.first.cart_items[0].id,
            user.carts.first.cart_items[1].id,
          ]) }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
    end
  end
end
