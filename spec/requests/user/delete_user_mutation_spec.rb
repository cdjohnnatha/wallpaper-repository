# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::User::DeleteUserMutation , type: :request do
  let(:user) { create(:user) }
  let(:valid_attr) { attributes_for(:user).to_h }

  describe "Delete user mutation" do
    context "valid attrs" do
      let(:mutation) { %| mutation { deleteUser(input: { id: #{user.id} }) { user { id, firstName, lastName, email } } } | }

      before { post '/graphql', params: { query: mutation } }

      it "it should be success" do
        expect(graphql_response["deleteUser"]).not_to(be_empty)
        expect(graphql_response["deleteUser"]["user"]["id"].to_i).to(eq(user[:id]))
        expect(graphql_response["deleteUser"]["user"]["firstName"]).to(eq(user[:first_name]))
        expect(graphql_response["deleteUser"]["user"]["lastName"]).to(eq(user[:last_name]))
        expect(graphql_response["deleteUser"]["user"]["email"]).to(eq(user[:email]))
      end
    end
    context "Testing errors" do
      context "when a required attribute is nil" do
        let(:mutation) { %| mutation { deleteUser(input: { }) { user { id, firstName, lastName, email } } } | }

        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
      end

      context "when is send a wrong attribute" do
        let(:mutation) { %| mutation { deleteUser(input: { name: #{user.id}" }) { user { id, firstName, lastName, email } } } | }

        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
      end

      context "not found id" do
        let(:mutation) { %| mutation { deleteUser(input: { id: -1 }) { user { id, firstName, lastName, email } } } | }

        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
      end
    end
  end
end
