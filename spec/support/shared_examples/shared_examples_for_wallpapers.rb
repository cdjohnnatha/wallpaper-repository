# frozen_string_literal: true
RSpec.shared_examples("a wallpaper fields") do |query_object|
  it "should returns wallpaper fields" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_response[query_object]["wallpaper"]).to(have_key("filename"))
    expect(graphql_response[query_object]["wallpaper"]).to(have_key("price"))
    expect(graphql_response[query_object]["wallpaper"]).to(have_key("qtyAvailable"))
    expect(graphql_response[query_object]["wallpaper"]).to(have_key("id"))
  end
end
