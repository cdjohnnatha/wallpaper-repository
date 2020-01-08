# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::Auth::SignUpMutation) do
  let(:user) { create(:user) }
  let(:context) { {} }
  let(:variables) { {} }
  # Call `result` to execute the query
  let(:result) do
    res = WallpaperRepositorySchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    if res["errors"]
      pp(res)
    end
    res
  end
  let(:valid_attr) { attributes_for(:user).to_h }

  describe "testing signUp mutations query" do
    context "create new User" do
      let(:query_string) do
        %|
        mutation { signUp(input: {
          firstName: "#{valid_attr[:first_name]}",
          lastName: "#{valid_attr[:last_name]}",
          authProvider: {
            email: "#{valid_attr[:email]}",
            password: "#{valid_attr[:password]}"
          }
        }) { user { id, firstName, lastName, email } } } |
      end

      context "it has right params" do
        it_behaves_like "an user fields", "signUp"
        it "expected to errors be null" do
          expect(result["errors"]).to(be_blank)
        end
      end
      context "when uses existent email" do
        let(:query_string) do
          %|
          mutation { signUp(input: {
            firstName: "#{user[:first_name]}",
            lastName: "#{user[:last_name]}",
            authProvider: {
              email: "#{user[:email]}",
              password: "#{user[:password]}"
            }
          }) { user { id, firstName, lastName, email } } } |
        end
        it "should be user:null" do
          expect(result["errors"]).not_to(be_blank)
        end
      end
      context "when send required parameter as nil" do
        let(:query_string) do
          %|
          mutation { signUp(input: {
            firstName: "#{user[:first_name]}",
            lastName: "#{user[:last_name]}",
            authProvider: {
              email: "",
              password: "#{user[:password]}"
            }
          }) { user { id, firstName, lastName, email } } } |
        end
        it "should be user:null" do
          expect(result["errors"]).not_to(be_blank)
        end
      end
    end
  end
end
