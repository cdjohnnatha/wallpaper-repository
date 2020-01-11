require 'rails_helper'

RSpec.describe Mutations::UserWallpaper::CreateUserWallpaperMutation, type: :request do
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
              quantity: #{valid_attr[:quantity]}
              image: { filename: "#{valid_attr[:filename]}", file: $file }
            }
          ) {
            wallpaper {
              id
              filename
              price
              quantity
            }
            errors
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

      it 'create comment' do
        # expect(response).to match_schema(CreateCommentSchema::Success)
        expect(response).to be_ok
      end
    end
  end
end
