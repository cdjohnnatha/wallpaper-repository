# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::UserWallpaper::CreateUserWallpaperMutation, type: :request) do
  let(:user) { create(:user) }
  let(:valid_attr) { attributes_for(:wallpaper).to_h }
  describe "testing create wallpaper mutations query" do
    let(:mutation) do
      %|
        mutation($file: Upload!) {
          createWallpaper(
            input: {
              userId: #{user.id}
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

      it_behaves_like "a wallpaper fields", "createWallpaper"

      it 'create user wallpaper' do
        expect(response).to(be_ok)
        expect(graphql_errors).to(be_blank)
      end
    end
    context "invalid" do
      context "missing param price" do
        let(:mutation) do
          %|
            mutation($file: Upload!) {
              createWallpaper(
                input: {
                  userId: #{user.id}
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
              createWallpaper(
                input: {
                  userId: #{user.id}
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
              createWallpaper(
                input: {
                  userId: #{user.id}
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
              createWallpaper(
                input: {
                  userId: #{user.id}
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
