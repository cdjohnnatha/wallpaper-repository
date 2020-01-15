# frozen_string_literal: true
RSpec.shared_examples("a pagination") do |query_object|
  it "should have pagination structure" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_response[query_object]).to(have_key("paginate"))
    expect(graphql_response[query_object]["paginate"]).to(have_key("currentPage"))
    expect(graphql_response[query_object]["paginate"]).to(have_key("totalPages"))
    expect(graphql_response[query_object]["paginate"]).to(have_key("rowsPerPage"))
    expect(graphql_errors).to(be_blank)
  end
end
