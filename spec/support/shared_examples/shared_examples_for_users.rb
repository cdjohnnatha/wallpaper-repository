# frozen_string_literal: true
RSpec.shared_examples("an user fields") do |query_object|
  it "should returns users fields" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_response[query_object]["user"]).to(have_key("email"))
    expect(graphql_response[query_object]["user"]).to(have_key("firstName"))
    expect(graphql_response[query_object]["user"]).to(have_key("lastName"))
    expect(graphql_response[query_object]["user"]).to(have_key("id"))
  end
end
