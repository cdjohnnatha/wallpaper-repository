# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::User::UpdateUserMutation, type: :request do
  let(:user) { create(:user) }
  let(:valid_attr) { attributes_for(:user).to_h }

  def mutation(user_id, attr)
    <<~GQL
      mutation {
        updateUser(input: {
          id: #{user_id},
          firstName: "#{attr[:first_name]}",
          lastName: "#{attr[:last_name]}",
          email: "#{attr[:email]}"
          }) {
          user { id, firstName, lastName, email }
        }
      }
    GQL
  end
  describe "Update user mutation" do
    context "updating User" do
      context "updating full entries" do
        before { post '/graphql', params: { query: mutation(user.id, valid_attr) } }
        it "expected to have a name and email updated" do
          expect(graphql_response["updateUser"]).to(have_key("user"))
          expect(graphql_response["updateUser"]["user"]["firstName"]).to(eq(valid_attr[:first_name]))
          expect(graphql_response["updateUser"]["user"]["lastName"]).to(eq(valid_attr[:last_name]))
          expect(graphql_response["updateUser"]["user"]["email"]).to(eq(valid_attr[:email]))
        end
        it "expected to errors be null" do
          expect(graphql_response["updateUser"]["errors"]).to(be_blank)
        end
      end
      context "updating only one field first_name" do
        let(:query_string) {
          <<~GQL
            mutation {
              updateUser(input: {
                id: #{user.id},
                firstName: "#{valid_attr[:first_name]}",
                }) {
                user { id, firstName, lastName, email }
              }
            }
          GQL
        }

        before { post '/graphql', params: { query: query_string } }

        it "has the first_name updated" do
          expect(graphql_response["updateUser"]["user"]).not_to(be_blank)
          expect(graphql_response["updateUser"]["user"]["firstName"]).to(eq(valid_attr[:first_name]))
        end
        it "expected to errors be null" do
          expect(graphql_response["updateUser"]["errors"]).to(be_blank)
        end
      end

      context "Testing errors" do
        context "when a required attribute is nil" do
          let(:query_string) {
            <<~GQL
              mutation {
                updateUser(input: {
                  id: #{user.id},
                  }) {
                  user { id, firstName, lastName, email }
                }
              }
            GQL
          }
          before { post '/graphql', params: { query: query_string } }

          it_behaves_like "a common error"
        end

        context "when is send a wrong attribute" do
          let(:query_string) {
            <<~GQL
              mutation {
                updateUser(input: {
                  id: #{user.id},
                  middleName: "someone"
                  }) {
                  user { id, firstName, lastName, email }
                }
              }
            GQL
          }
          before { post '/graphql', params: { query: query_string } }
          it_behaves_like "a common error"
        end
        context "when is missing id" do
          let(:query_string) {
            <<~GQL
              mutation {
                updateUser(input: {
                  firstName: "#{valid_attr[:first_name]}",
                  lastName: "#{valid_attr[:last_name]}",
                  email: "#{valid_attr[:email]}"
                  }) {
                  user { id, firstName, lastName, email }
                }
              }
            GQL
          }
          before { post '/graphql', params: { query: query_string } }
          it_behaves_like "a common error"
        end
      end
    end
  end
end
