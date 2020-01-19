# frozen_string_literal: true
RSpec.shared_examples("a success query/mutation") do
  it "should not be blank the response" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_errors).to(be_blank)
  end
end

RSpec.shared_examples("a partial success query/mutation") do
  it "should not be blank the response" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_errors).not_to(be_blank)
    expect(graphql_errors).not_to(be_empty)
  end
end
