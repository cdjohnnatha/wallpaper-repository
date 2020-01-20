# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Mutations::Category::CreateCategoryMutation, type: :request) do
  let(:admin_user) { create(:user, :with_admin_role) }
  let(:user) { create(:user) }
  let(:valid_attr) { attributes_for(:category).to_h }
  let(:invalid_attr) { attributes_for(:category, name: nil).to_h }

  def mutation(name)
    %|
      mutation {
        createCategory(input: { name: "#{name}" }) {
          category {
            id
            name
          }
        }
      }
    |
  end

  describe "Create a new category" do
    context "authenticated" do
      context "success" do
        before do
          post '/graphql', params: { query: mutation(valid_attr[:name]) }, headers: authenticated_header(admin_user)
        end

        it_behaves_like "a category fields", "createCategory"
      end
      context "create without permissions" do
        before do
          post '/graphql', params: { query: mutation(valid_attr[:name]) }, headers: authenticated_header(user)
        end

        it_behaves_like "a common error"
        it_behaves_like "unauthorized access level"
      end
      context "invalid" do
        context "params" do
          before do
            post '/graphql', params: { query: mutation(invalid_attr[:name]) }, headers: authenticated_header(admin_user)
          end

          it_behaves_like "a common error"
        end
        context "missing param name" do
          let(:mutation) do
            %|
              mutation {
                createCategory(input: {}) {
                  category {
                    id
                    name
                  }
                }
              }
            |
          end
          before do
            post '/graphql', params: { query: mutation }, headers: authenticated_header(admin_user)
          end

          it_behaves_like "a common error"
        end
      end
    end # authenticated

    context "not authenticated" do
      context "success" do
        before do
          post '/graphql', params: { query: mutation(valid_attr[:name]) }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
      context "create without permissions" do
        before do
          post '/graphql', params: { query: mutation(valid_attr[:name]) }
        end

        it_behaves_like "a common error"
        it_behaves_like "not authenticated"
      end
      context "invalid" do
        context "params" do
          before do
            post '/graphql', params: { query: mutation(invalid_attr[:name]) }
          end

          it_behaves_like "a common error"
          it_behaves_like "not authenticated"
        end
        context "missing param name" do
          let(:mutation) do
            %|
              mutation {
                createCategory(input: {}) {
                  category {
                    id
                    name
                  }
                }
              }
            |
          end
          before do
            post '/graphql', params: { query: mutation }
          end

          it_behaves_like "a common error"
        end
      end
    end
  end
end
