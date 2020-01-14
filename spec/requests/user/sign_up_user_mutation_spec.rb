# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::Auth::SignUpMutation) do
  let(:user) { create(:user) }
  let(:valid_attr) { attributes_for(:user).to_h }

  describe "testing signUp mutations query" do
    context "create new User" do
      context "it has valid attributes" do
        let(:mutation) do
          <<~GQL
            mutation {
              signUp(
                input: {
                  firstName: "#{valid_attr[:first_name]}",
                  lastName: "#{valid_attr[:last_name]}",
                  authProvider: {
                    email: "#{valid_attr[:email]}",
                    password: "#{valid_attr[:password]}"
                  }
                }) { user { id, firstName, lastName, email } token } }
            GQL
        end

        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "an user fields", "signUp"
        it "expected to errors be null" do
          expect(graphql_errors).to(be_blank)
        end
      end
      context "when uses existent email" do
        let(:mutation) do
          <<~GQL
            mutation {
              signUp(input: {
                firstName: "#{user[:first_name]}",
                lastName: "#{user[:last_name]}",
                authProvider: {
                  email: "#{user[:email]}",
                  password: "#{user[:password]}"
                }
            }) { user { id, firstName, lastName, email } } }
          GQL
        end

        before { post '/graphql', params: { query: mutation } }
        it_behaves_like "a common error"
      end
      context "when send required parameter as nil" do
        let(:mutation) do
          <<~GQL
            mutation {
              signUp(input: {
              firstName: "#{user[:first_name]}",
              lastName: "#{user[:last_name]}",
              authProvider: {
                email: #{nil},
                password: "#{user[:password]}"
              }
            }) { user { id, firstName, lastName, email } } }
          GQL
        end

        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
      end
      context "when send wrong email format" do
        let(:mutation) do
          <<~GQL
            mutation {
              signUp(input: {
              firstName: "#{user[:first_name]}",
              lastName: "#{user[:last_name]}",
              authProvider: {
                email: "aaaaaaa@a",
                password: "#{user[:password]}"
              }
            }) { user { id, firstName, lastName, email } } }
          GQL
        end

        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
      end
    end
  end
end
