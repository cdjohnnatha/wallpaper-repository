# frozen_string_literal: true
RSpec.shared_examples("a category fields") do |query_object|
  it "should return a category fields" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_response[query_object]["category"]).to(have_key("name"))
    expect(graphql_response[query_object]["category"]).to(have_key("id"))
  end
end

RSpec.shared_examples("a category list") do |query_object|
  it "should have a list of categories" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_response[query_object]["values"]).to(be_an_instance_of(Array))
    expect(graphql_response[query_object]["values"].first).to(have_key("id"))
    expect(graphql_response[query_object]["values"].first).to(have_key("name"))
    expect(graphql_errors).to(be_blank)
  end
end
