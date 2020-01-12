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
              path
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

      it 'update user wallpaper shouldnt have errors' do
        expect(graphql_errors).to(be_blank)
      end
    end

    context "invalid" do
      context "missing param price" do
        let(:mutation) do
          %|
            mutation($file: Upload!) {
              updateUserWallpaper(
                input: {
                  id: #{user_wallpaper.id}
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
                errors
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

      context "missing param qtyAvailable" do
        let(:mutation) do
          %|
            mutation($file: Upload!) {
              updateUserWallpaper(
                input: {
                  id: #{user_wallpaper.id}
                  price: #{valid_attr[:price]}
                  image: { filename: "#{valid_attr[:filename]}", file: $file }
                }
              ) {
                wallpaper {
                  id
                  filename
                  price
                  qtyAvailable
                }
                errors
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

      context "missing param file" do
        let(:mutation) do
          %|
            mutation($file: Upload!) {
              updateUserWallpaper(
                input: {
                  id: #{user_wallpaper.id}
                  price: #{valid_attr[:price]}
                  image: { filename: "#{valid_attr[:filename]}" }
                }
              ) {
                wallpaper {
                  id
                  filename
                  price
                  qtyAvailable
                }
                errors
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

      context "missing param filename" do
        let(:mutation) do
          %|
            mutation($file: Upload!) {
              updateUserWallpaper(
                input: {
                  id: #{user_wallpaper.id}
                  price: #{valid_attr[:price]}
                  image: { file: $file }
                }
              ) {
                wallpaper {
                  id
                  filename
                  price
                  qtyAvailable
                }
                errors
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
