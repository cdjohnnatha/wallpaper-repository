# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::UserWallpaper::UpdateUserWallpaper, type: :request) do
  let(:user) { create(:user) }
  let(:user_wallpaper) { create(:wallpaper) }
  let(:valid_attr) { attributes_for(:wallpaper).to_h }
  let(:valid_wallpaper_price_attr) { attributes_for(:wallpaper_price).to_h }
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

  describe "testing update wallpaper mutations query" do
    let(:mutation) do
      %|
        mutation($file: Upload!) {
          updateUserWallpaper(
            input: {
              id: #{user_wallpaper.id}
              price: #{valid_wallpaper_price_attr[:price]}
              qtyAvailable: #{valid_attr[:qty_available]}
              image: { filename: "#{valid_attr[:filename]}", file: $file }
            }
          )
          #{wallpaper_fragment}
        }
      |
    end
    context "authorized" do
      context "success" do
        let(:variables) do
          { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
        end

        before do
          post '/graphql',
          params: { query: mutation, variables: variables },
          headers: authenticated_header(user_wallpaper.user)
        end
        it_behaves_like "a wallpaper fields", "updateUserWallpaper", true
      end

      context "invalid" do
        context "missing id" do
          let(:mutation) do
            %|
              mutation($file: Upload!) {
                updateUserWallpaper(
                  input: {
                    qtyAvailable: #{valid_attr[:qty_available]}
                    image: { filename: "#{valid_attr[:filename]}", file: $file }
                  }
                )
                #{wallpaper_fragment}
              }
            |
          end
          let(:variables) do
            { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
          end

          before do
            post '/graphql',
            params: { query: mutation, variables: variables },
            headers: authenticated_header(user_wallpaper.user)
          end

          it_behaves_like "a common error"
        end

        context "missing all params" do
          let(:mutation) do
            %|
              mutation($file: Upload!) {
                updateUserWallpaper(
                  input: {
                    id: #{user_wallpaper.id}
                  }
                )
                #{wallpaper_fragment}
              }
            |
          end
          let(:variables) do
            { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
          end

          before do
            post '/graphql',
            params: { query: mutation, variables: variables },
            headers: authenticated_header(user_wallpaper.user)
          end

          it_behaves_like "a common error"
        end

        context "send .txt file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.txt', 'application/text') }
          end

          before do
            post '/graphql',
            params: { query: mutation, variables: variables },
            headers: authenticated_header(user_wallpaper.user)
          end

          it_behaves_like "a common error"
        end

        context "send .pdf file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.pdf', 'application/pdf') }
          end

          before do
            post '/graphql',
            params: { query: mutation, variables: variables },
            headers: authenticated_header(user_wallpaper.user)
          end

          it_behaves_like "a common error"
        end

        context "send .zip file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.zip', 'application/zip') }
          end

          before do
            post '/graphql',
            params: { query: mutation, variables: variables },
            headers: authenticated_header(user_wallpaper.user)
          end

          it_behaves_like "a common error"
        end

        context "send .json file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.json', 'application/json') }
          end

          before do
            post '/graphql',
            params: { query: mutation, variables: variables },
            headers: authenticated_header(user_wallpaper.user)
          end

          it_behaves_like "a common error"
        end

        context "try update other user wallpaper" do
          let(:variables) do
            { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
          end
          before do
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "unauthorized", "update" do
            let(:model) { user_wallpaper }
          end
        end
      end
      context "unauthorized" do
        context "valid params" do
          let(:variables) do
            { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
          end

          before { post '/graphql', params: { query: mutation, variables: variables } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end
        context "try update other user wallpaper" do
          let(:variables) do
            { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
          end
          before { post '/graphql', params: { query: mutation, variables: variables } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end

        context "send .txt file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.txt', 'application/text') }
          end

          before { post '/graphql', params: { query: mutation, variables: variables } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end

        context "send .pdf file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.pdf', 'application/pdf') }
          end

          before { post '/graphql', params: { query: mutation, variables: variables } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end

        context "send .zip file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.zip', 'application/zip') }
          end

          before { post '/graphql', params: { query: mutation, variables: variables } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end

        context "send .json file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.json', 'application/json') }
          end

          before { post '/graphql', params: { query: mutation, variables: variables } }

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end
      end
    end
  end
end
