# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::UserWallpaper::CreateUserWallpaperMutation, type: :request) do
  let(:user) { create(:user) }
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
  describe "testing create wallpaper mutations query" do
    let(:mutation) do
      %|
        mutation($file: Upload!) {
          createWallpaper(
            input: {
              price: #{valid_wallpaper_price_attr[:price]}
              qtyAvailable: #{valid_attr[:qty_available]}
              image: { filename: "#{valid_attr[:filename]}", file: $file }
            }
          )
          #{wallpaper_fragment}
        }
      |
    end
    context "authenticated" do
      context "success" do
        let(:variables) do
          { file: fixture_file_upload('files/tree.jpg', 'image/jpg') }
        end

        before do
          post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
        end

        it_behaves_like "a wallpaper fields", "createWallpaper", true

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
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end
        context "missing param qtyAvailable" do
          let(:mutation) do
            %|
              mutation($file: Upload!) {
                createWallpaper(
                  input: {
                    price: #{valid_wallpaper_price_attr[:price]}
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
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end
        context "missing param file" do
          let(:mutation) do
            %|
              mutation($file: Upload!) {
                createWallpaper(
                  input: {
                    price: #{valid_wallpaper_price_attr[:price]}
                    image: { filename: "#{valid_attr[:filename]}" }
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
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end

        context "missing param filename" do
          let(:mutation) do
            %|
              mutation($file: Upload!) {
                createWallpaper(
                  input: {
                    price: #{valid_wallpaper_price_attr[:price]}
                    image: { file: $file }
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
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end

        context "send .txt file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.txt', 'application/text') }
          end

          before do
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end
        context "send .pdf file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.pdf', 'application/pdf') }
          end

          before do
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end
        context "send .zip file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.zip', 'application/zip') }
          end

          before do
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end
        context "send .json file" do
          let(:variables) do
            { file: fixture_file_upload('files/shopify.json', 'application/json') }
          end

          before do
            post '/graphql', params: { query: mutation, variables: variables }, headers: authenticated_header(user)
          end

          it_behaves_like "a common error"
        end
      end # end authenticated

      context "unauthorized" do
        context "valid attributes" do
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
