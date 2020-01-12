require 'rails_helper'

RSpec.describe(Mutations::UserWallpaper::UpdateUserWallpaper, type: :request) do
  let(:user_wallpaper) { create(:wallpaper) }
  let(:valid_attr) { attributes_for(:wallpaper).to_h }

  describe "testing update wallpaper mutations query" do
    let(:mutation) do
      %|
        mutation($file: Upload!) {
          updateUserWallpaper(
            input: {
              id: #{user_wallpaper.id}
              price: #{valid_attr[:price]}
              qtyAvailable: #{valid_attr[:qty_available]}
              image: { filename: "#{valid_attr[:filename]}", file: $file }
            }
          ) {
            wallpaper {
              id
              filename
              price
              qtyAvailable
              wallpaperUrl
            }
          }
        }
      |
    end

    context "success" do
      let(:variables) do
        { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
      end

      before { post '/graphql', params: { query: mutation, variables: variables } }

      it_behaves_like "a wallpaper fields", "updateUserWallpaper"
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
              ) {
                wallpaper {
                  id
                  filename
                  price
                  qtyAvailable
                }
              }
            }
          |
        end
        let(:variables) do
          { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
        end

        before { post '/graphql', params: { query: mutation, variables: variables } }

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
              ) {
                wallpaper {
                  id
                  filename
                  price
                  qtyAvailable
                }
              }
            }
          |
        end
        let(:variables) do
          { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
        end

        before { post '/graphql', params: { query: mutation, variables: variables } }

        it_behaves_like "a common error"
      end

      context "send .txt file" do
        let(:variables) do
          { file: fixture_file_upload('files/shopify.txt', 'application/text') }
        end

        before { post '/graphql', params: { query: mutation, variables: variables } }

        it_behaves_like "a common error"
      end

      context "send .pdf file" do
        let(:variables) do
          { file: fixture_file_upload('files/shopify.pdf', 'application/pdf') }
        end

        before { post '/graphql', params: { query: mutation, variables: variables } }

        it_behaves_like "a common error"
      end

      context "send .zip file" do
        let(:variables) do
          { file: fixture_file_upload('files/shopify.zip', 'application/zip') }
        end

        before { post '/graphql', params: { query: mutation, variables: variables } }

        it_behaves_like "a common error"
      end

      context "send .json file" do
        let(:variables) do
          { file: fixture_file_upload('files/shopify.json', 'application/json') }
        end

        before { post '/graphql', params: { query: mutation, variables: variables } }

        it_behaves_like "a common error"
      end
    end
  end
end
