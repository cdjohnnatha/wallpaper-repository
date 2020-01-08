require 'rails_helper'

RSpec.describe Mutations::SignInUser do
  let(:user) { create(:user) }
  let(:context) { {
  } }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) {
    res = WallpaperRepositorySchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    if res["errors"]
      pp res
    end
    res
  }
  let(:valid_attr) { attributes_for(:user).to_h }

  describe "testing create mutations query" do
    context "creating User" do
      let(:query_string) { %| mutation { signUp(name: "#{valid_attr[:name]}", authProvider: { email: { email: "#{valid_attr[:email]}", password: "#{valid_attr[:password]}" } }) { user { id, name, email } } } | }

      context "when there's current user" do
        it_behaves_like "an user attributes" do
          let(:query_object) { "createUser" }
          let(:attrs) { valid_attr }
        end
        it "expected to errors be null" do
          expect(result["errors"]).to be_blank
        end
      end
    end
  end
end 