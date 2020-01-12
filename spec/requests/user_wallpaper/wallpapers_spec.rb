require 'rails_helper'

RSpec.describe "Wallpapers", type: :request do
  let(:query) do
    %|
      {
        wallpapers(pagination: {
          currentPage: 0,
          rowsPerPage: 3
        }){
          paginate {
            currentPage
            totalPages
            rowsPerPage
          }
          values {
            id
            description
            price
            qtyAvailable
            wallpaperUrl
            seller{
              id
              fullName
            }
          }
        }
      }
    |
  end
  describe "List wallpapers" do
    before { create_list(:wallpaper, 3) }

    context "success" do
      before { post '/graphql', params: { query: query } }

      it_behaves_like "a wallpaper list", "wallpapers"

      it "should have 3 elements" do
        expect(graphql_response["wallpapers"]["values"].length).to(eq(3))
      end
    end
  end
end
