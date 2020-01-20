# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::Category::DeleteCategoryMutation, type: :request) do
  let(:admin_user) { create(:user, :with_admin_role) }
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe "Delete category" do
    let(:mutation) do
      %|
        mutation {
          deleteCategory(input: { id: #{category.id}}) {
            category { id name }
          }
        }
      |
    end

    context "authenticated" do
      context "valid params" do
        before { post '/graphql', params: { query: mutation }, headers: authenticated_header(admin_user) }

        it_behaves_like "a category fields", "deleteCategory", true
      end
      context "Testing errors" do
        context "try to delete category without permissions" do
          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(user) }

          it_behaves_like "a common error"
          it_behaves_like "unauthorized access level"
        end
        context "when a required attribute is nil" do
          let(:mutation) do
            %|
            mutation {
              deleteCategory(input: { id: nil) {
                category { id name }
              }
            }
          |
          end

          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(admin_user) }
          it_behaves_like "a common error"
        end

        context "when is send a wrong attribute" do
          let(:mutation) do
            %|
            mutation {
              deleteCategory(input: { name: #{category.id}}) {
                category { id name }
              }
            }
          |
          end

          before { post '/graphql', params: { query: mutation }, headers: authenticated_header(admin_user) }

          it_behaves_like "a common error"
        end
      end
    end # end authenticated

    context "unauthorized" do
      context "valid params" do
        before { post '/graphql', params: { query: mutation } }

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
    end
  end
end
