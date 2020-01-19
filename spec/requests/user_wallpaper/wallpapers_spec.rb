# frozen_string_literal: true
require 'rails_helper'

RSpec.describe("Wallpapers", type: :request) do
  let(:wallpaper) { create(:wallpaper) }
  let(:wallpaper_fragment) {
    %|
      {
        id
        description
        wallpaperPrice {
          id
          price
        }
        qtyAvailable
        wallpaperUrl
        seller{
          id
          fullName
          email
        }
      }
    |
  }
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
          values #{wallpaper_fragment}
        }
      }
    |
  end
  describe "Listing all wallpapers" do
    before { create_list(:wallpaper, 3) }

    context "success" do
      before { post '/graphql', params: { query: query } }

      it_behaves_like "a wallpaper list" do
        let(:wallpaperList) { graphql_response['wallpapers']['values'] }
      end

      it "should have 3 elements" do
        expect(graphql_response["wallpapers"]["values"].length).to(eq(3))
      end
    end
  end

  describe "Single wallpaper queries" do
    describe "Single wallpaper informations" do
      context "success" do
        context "all attributes" do
          let(:query) do
            %|
              {
                wallpaper(wallpaperId: #{wallpaper.id}) #{wallpaper_fragment}
              }
            |
          end
          before { post '/graphql', params: { query: query } }

          it_behaves_like "a wallpaper fields" do
            let(:wallpaperFields) { graphql_response['wallpaper'] }
          end
          it_behaves_like "a wallpaper seller fields", "wallpaper"
        end
      end
      context "invalid" do
        context "Missing wallpaperId" do
          let(:query) do
            %|
              {
                wallpaper #{wallpaper_fragment}
              }
            |
          end
          before { post '/graphql', params: { query: query } }

          it_behaves_like "a common error"
        end
      end
    end
  end
end
