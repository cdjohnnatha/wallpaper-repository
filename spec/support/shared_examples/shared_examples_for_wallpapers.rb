# frozen_string_literal: true
RSpec.shared_examples("a wallpaper fields") do |query_object, has_object_name|
  it "should returns wallpaper fields" do
    data = graphql_response[query_object]
    if has_object_name
      data = data['wallpaper']
    end
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(data).to(have_key("wallpaperUrl"))
    expect(data).to(have_key("price"))
    expect(data).to(have_key("qtyAvailable"))
    expect(data).to(have_key("id"))
    expect(graphql_errors).to(be_blank)
  end
end

RSpec.shared_examples("a wallpaper seller fields") do |query_object, has_object_name|
  it "should have wallpapers seller fields" do
    data = graphql_response[query_object]
    if has_object_name
      data = data['wallpaper']
    end
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(data).to(have_key("seller"))
    expect(data["seller"]).to(have_key("email"))
    expect(data["seller"]).to(have_key("id"))
    expect(data["seller"]).to(have_key("fullName"))
    expect(graphql_errors).to(be_blank)
  end
end

RSpec.shared_examples("a wallpaper list") do |query_object|
  it "should have a list of wallpapers" do
    expect(graphql_response).not_to(be_blank)
    expect(graphql_response).not_to(be_empty)
    expect(graphql_response[query_object]["values"]).to(be_an_instance_of(Array))
    expect(graphql_response[query_object]["values"].first).to(have_key("id"))
    expect(graphql_response[query_object]["values"].first).to(have_key("wallpaperUrl"))
    expect(graphql_response[query_object]["values"].first).to(have_key("description"))
    expect(graphql_response[query_object]["values"].first).to(have_key("price"))
    expect(graphql_response[query_object]["values"].first).to(have_key("qtyAvailable"))
    expect(graphql_response[query_object]["values"].first).to(have_key("seller"))
    expect(graphql_response[query_object]["values"].first["seller"]).to(have_key("id"))
    expect(graphql_response[query_object]["values"].first["seller"]).to(have_key("fullName"))
    expect(graphql_errors).to(be_blank)
  end
end
