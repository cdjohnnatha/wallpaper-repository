# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::UserWallpaper::DeleteUserWallpaperMutation, type: :request) do
  let(:user) { create(:user) }
  let(:user_wallpaper) { create(:wallpaper) }
  let(:wallpaper_fragment) {
    %|
      {
        wallpaper {
          id
          filename
          wallpaperPrice {
            id
            price
          }
          qtyAvailable
          wallpaperUrl
        }
      }
    |
  }
  describe "DeleteUserWallpaperMutation" do
    let(:mutation) do
      %|
        mutation {
          deleteUserWallpaper(
            input: {
              id: #{user_wallpaper.id}
            }
          )
          #{wallpaper_fragment}
        }
      |
    end
    context "authenticated" do
      context "valid params" do
        before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user_wallpaper.user) }

        it_behaves_like "a wallpaper fields" do
          let(:wallpaperFields) { graphql_response['deleteUserWallpaper']['wallpaper'] }
        end
      end
      context "Testing errors" do
        context "try to delete other user wallpaper image" do
          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

          it_behaves_like "a common error"
          it_behaves_like "unauthorized", "delete" do
            let(:model) { user_wallpaper }
          end
        end
        context "when a required attribute is nil" do
          let(:mutation) do
            %|
            mutation {
              deleteUserWallpaper(
                input: {
                  id: nil
                }
              )
              #{wallpaper_fragment}
            }
          |
          end

          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }
          it_behaves_like "a common error"
        end

        context "when is send a wrong attribute" do
          let(:mutation) do
            %|
            mutation {
              deleteUserWallpaper(
                input: {
                  name: #{user_wallpaper.id}
                }
              )
              #{wallpaper_fragment}
            }
          |
          end

          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

          it_behaves_like "a common error"
        end
      end
    end # end authenticated

    context "unauthorized" do
      context "valid params" do
        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
    end
  end
end
