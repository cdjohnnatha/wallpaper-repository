# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Mutations::User::DeleteUserMutation) do
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

  describe "destroy user" do
    context "valid attrs" do
      let(:query_string) { %| mutation { deleteUser(input: { id: #{user.id} }) { user { id, firstName, lastName, email } } } | }
      it "it should be success" do
        expect(graphql_result["deleteUser"]).not_to(be_empty)
        expect(graphql_result["deleteUser"]["user"]["id"].to_i).to(eq(user[:id]))
        expect(graphql_result["deleteUser"]["user"]["firstName"]).to(eq(user[:first_name]))
        expect(graphql_result["deleteUser"]["user"]["lastName"]).to(eq(user[:last_name]))
        expect(graphql_result["deleteUser"]["user"]["email"]).to(eq(user[:email]))
      end
    end
    context "Testing errors" do
      context "when a required attribute is nil" do
        let(:query_string) { %| mutation { deleteUser(input: { id nil" }) { user { id, firstName, lastName, email } } } | }
        it_behaves_like "a common error"
      end

      context "when is send a wrong attribute" do
        let(:query_string) { %| mutation { deleteUser(input: { name: #{user.id}" }) { user { id, firstName, lastName, email } } } | }
        it_behaves_like "a common error"
      end

      context "not found id" do
        let(:query_string) { %| mutation { deleteUser(input: { id: -1 }) { user { id, firstName, lastName, email } } } | }
        it_behaves_like "a common error"
      end
    end
  end
end
