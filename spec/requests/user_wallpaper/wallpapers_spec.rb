require 'rails_helper'

RSpec.describe "Wallpapers", type: :request do
  let(:query) do
    %|
      {
        wallpapers{
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
    |
  end
  describe "List wallpapers" do
    before { create_list(:wallpaper, 3) }

    context "success" do
      before { post '/graphql', params: { query: query } }

      it_behaves_like "a wallpaper list", "wallpapers"
    end
  end
end
