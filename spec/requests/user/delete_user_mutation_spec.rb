# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Mutations::User::DeleteUserMutation, type: :request) do
  let(:user) { create(:user) }
  let(:valid_attr) { attributes_for(:user).to_h }

  describe "Delete user mutation" do
    context "authenticated" do
      context "valid attrs" do
        let(:mutation) do
          %|
            mutation {
              deleteUser(input: { confirmPassword: "#{user.password}" }){ user { id, firstName, lastName, email } }
            } |
        end
        before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

        it "it should be success" do
          expect(graphql_response["deleteUser"]).not_to(be_empty)
          expect(graphql_response["deleteUser"]["user"]["id"].to_i).to(eq(user[:id]))
          expect(graphql_response["deleteUser"]["user"]["firstName"]).to(eq(user[:first_name]))
          expect(graphql_response["deleteUser"]["user"]["lastName"]).to(eq(user[:last_name]))
          expect(graphql_response["deleteUser"]["user"]["email"]).to(eq(user[:email]))
        end
      end
      context "Testing errors" do
        context "when it has wrong password" do
          let(:mutation) do
            %|
              mutation {
                deleteUser(input: { confirmPassword: "#{user.password}1" }){ user { id, firstName, lastName, email } }
              } |
          end
          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }
          it_behaves_like "a common error"
        end
        context "when a required attribute is nil" do
          let(:mutation) do
            %| mutation {
                deleteUser(input: { confirmPassword: #{nil} }) { user { id, firstName, lastName, email } }
              } |
          end

          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }
          it_behaves_like "a common error"
        end

        context "when is send a wrong attribute" do
          let(:mutation) do
            %| mutation {
              deleteUser(input: { name: #{user.id}" }) { user { id, firstName, lastName, email } }
              } |
          end

          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

          it_behaves_like "a common error"
        end
      end
    end
    context "unauthorized" do
      context "valid attrs" do
        let(:mutation) do
          %|
            mutation {
              deleteUser(input: { confirmPassword: "#{user.password}" }){ user { id, firstName, lastName, email } }
            } |
        end
        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
    end
  end
end
