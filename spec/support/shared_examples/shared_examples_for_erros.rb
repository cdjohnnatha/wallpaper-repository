# frozen_string_literal: true

# RSpec.shared_examples("an unauthorized") do |object_name, object_action|
#   it "should be unauthorized" do
#     expect(result["data"]).to_not(be_blank)
#     expect(result["data"][object_name]).to(be_nil)
#     expect(result["errors"]).to_not(be_blank)
#     expect(result["errors"].first["message"]).to(eq("Not authorized to access #{object_name}.#{object_action}"))
#   end
# end

RSpec.shared_examples("a common error") do
  it "should have error array filled" do
    expect(graphql_errors).to_not(be_blank)
    expect(graphql_errors.first).to(have_key("message"))
  end
end

RSpec.shared_examples("not authenticated") do
  it "should have an unauthorized message" do
    expect(graphql_errors.first["message"]).to(eq("You are unauthorized"))
  end
end

RSpec.shared_examples("unauthorized") do |action, model|
  it "should have an unauthorized message" do
    error_message = %|You are unauthorized to proceed with the action #{action} to #{model}|
    expect(graphql_errors.first["message"]).to(eq(error_message))
  end
end
