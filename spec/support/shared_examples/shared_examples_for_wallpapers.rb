# frozen_string_literal: true
RSpec.shared_examples("a wallpaper fields") do
  it "should returns wallpaper fields" do
    expect(wallpaperFields).to(have_key("wallpaperUrl"))
    expect(wallpaperFields).to(have_key("qtyAvailable"))
    expect(wallpaperFields).to(have_key("id"))
    expect(wallpaperFields).to(have_key("wallpaperPrice"))
    expect(wallpaperFields['wallpaperPrice']).to(have_key("id"))
    expect(wallpaperFields['wallpaperPrice']).to(have_key("price"))
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

RSpec.shared_examples("a wallpaper list") do
  it "should have a list of wallpapers" do
    raise wallpaperList.inspect
    expect(wallpaperList).to(be_an_instance_of(Array))
    expect(wallpaperList.first).to(have_key("id"))
    expect(wallpaperList.first).to(have_key("wallpaperUrl"))
    expect(wallpaperList.first).to(have_key("description"))
    expect(wallpaperList.first).to(have_key("qtyAvailable"))
    expect(wallpaperList.first).to(have_key("seller"))
    expect(wallpaperList.first["seller"]).to(have_key("id"))
    expect(wallpaperList.first["seller"]).to(have_key("fullName"))
    expect(wallpaperList.first).to(have_key("wallpaperPrice"))
    expect(wallpaperList.first['wallpaperPrice']).to(have_key("id"))
    expect(wallpaperList.first['wallpaperPrice']).to(have_key("price"))
    expect(graphql_errors).to(be_blank)
  end
end
