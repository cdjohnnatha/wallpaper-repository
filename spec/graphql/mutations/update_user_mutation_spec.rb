# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Mutations::User::UpdateUserMutation) do
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

  describe "testing update user mutations query" do
    context "updating User" do
      context "updating full entries" do
        let(:query_string) do
          %| mutation {
            updateUser(input: {
              id: #{user.id},
              firstName: "#{valid_attr[:first_name]}",
              lastName: "#{valid_attr[:last_name]}",
              email: "#{valid_attr[:email]}"
              }) {
                user { id, firstName, lastName, email }
                }
            } |
        end
        it "expected to have a name and email updated" do
          expect(graphql_result["updateUser"]).to(have_key("user"))
          expect(graphql_result["updateUser"]["user"]["firstName"]).to(eq(valid_attr[:first_name]))
          expect(graphql_result["updateUser"]["user"]["lastName"]).to(eq(valid_attr[:last_name]))
          expect(graphql_result["updateUser"]["user"]["email"]).to(eq(valid_attr[:email]))
        end
        it "expected to errors be null" do
          expect(graphql_result["updateUser"]["errors"]).to(be_blank)
        end
      end
      context "updating just email" do
        let(:query_string) { %| mutation { updateUser(input: { id: #{user.id}, email: "#{valid_attr[:email]}" }) { user { id, firstName, lastName, email } } } | }
        it "expected to have a name updated" do
          expect(graphql_result["updateUser"]["user"]).not_to(be_blank)
          expect(graphql_result["updateUser"]["user"]["email"]).to(eq(valid_attr[:email]))
        end
        it "expected to errors be null" do
          expect(graphql_result["updateUser"]["errors"]).to(be_blank)
        end
      end

      context "Testing errors" do
        context "when a required attribute is nil" do
          let(:query_string) { %| mutation { updateUser(input: { id #{user.id}, name: "nil", email: "#{valid_attr[:email]}" }) { user { id, firstName, lastName, email } } } | }
          it_behaves_like "a common error"
        end

        context "when is send a wrong attribute" do
          let(:query_string) { %| mutation { updateUser(input: { id: #{user.id}, surname: "nil" }) { user { id, firstName, lastName, email } } } | }
          it_behaves_like "a common error"
        end
        context "when is missing id" do
          let(:query_string) { %| mutation { updateUser(input: { surname: "nil" }) { user { id, firstName, lastName, email } } } | }
          it_behaves_like "a common error"
        end
      end
    end
  end
end
