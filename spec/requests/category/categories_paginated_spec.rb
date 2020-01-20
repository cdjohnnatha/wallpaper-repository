# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Types::QueryType, type: :request) do
  let(:category) { create(:category) }
  let(:query) do
    %|
      {
        categories(pagination: {
          currentPage: 0,
          rowsPerPage: 3
        }){
          paginate {
            currentPage
            totalPages
            rowsPerPage
          }
          values {
            id
            name
          }
        }
      }
    |
  end
  describe "Listing all categories" do
    before { create_list(:category, 3) }

    context "success" do
      before { post '/graphql', params: { query: query } }

      it_behaves_like "a category list", "categories"
      it_behaves_like "a pagination", "categories"

      it "should have 3 elements" do
        expect(graphql_response["categories"]["values"].length).to(eq(3))
      end
    end
  end
end
