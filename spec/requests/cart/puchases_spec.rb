require 'rails_helper'

RSpec.describe "Cart::Puchases", type: :request do
  let(:user) { create(:user, :with_cart) }
  let(:user_without_cart) { create(:user) }
  let(:purchaseFragment) {
    %|
    {
      order
        {
          id 
          totalAmount
          totalItems
          paymentMethod
          status
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
              wallpaperUrl
              wallpaperPrice {
                id
                price
              }
            }
          }
        }
      }
    |
  }
  def mutation(payment_method)
    %|
      mutation{
        purchaseCart(input: {
          paymentMethod: #{payment_method}
        }) #{purchaseFragment}
      }
    |
  end

  describe "Purchase cart" do
    before { create_list(:wallpaper, 3) }
    context "authenticated" do
      context "success purchase debit_cart" do
        before do
          post '/graphql', params: { query: mutation('debit_card') }, headers: authenticated_header(user)
          @purchase = graphql_response["purchaseCart"]['order']
        end

        it_behaves_like 'an order fields', 'debit_card', 'created' do
          let(:order) { @purchase }
        end

        it_behaves_like 'an order item fields', 'debit_card', 'created' do
          let(:order) { @purchase['orderItems'].first }
        end

        it_behaves_like 'a wallpaper fields', 'debit_card', 'created' do
          let(:wallpaperFields) { @purchase['orderItems'].first['wallpaper'] }
        end
      end
      context "success purchase credit_card" do
        before do
          post '/graphql', params: { query: mutation('credit_card') }, headers: authenticated_header(user)
          @purchase = graphql_response["purchaseCart"]['order']
        end

        it_behaves_like 'an order fields', 'credit_card', 'created' do
          let(:order) { @purchase }
        end

        it_behaves_like 'an order item fields' do
          let(:order) { @purchase['orderItems'].first }
        end

        it_behaves_like 'a wallpaper fields', 'credit_card', 'created' do
          let(:wallpaperFields) { @purchase['orderItems'].first['wallpaper'] }
        end
      end
      context "try purchase with empty cart" do
        before do
          post '/graphql', params: { query: mutation('credit_card') }, headers: authenticated_header(user_without_cart)
        end

        it_behaves_like "a common error"
      end
    end
    context "not authenticated" do
      context "success purchase debit_cart" do
        before do
          post '/graphql', params: { query: mutation('debit_card') }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
      context "success purchase credit_card" do
        before do
          post '/graphql', params: { query: mutation('credit_card') }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
    end
  end
end
