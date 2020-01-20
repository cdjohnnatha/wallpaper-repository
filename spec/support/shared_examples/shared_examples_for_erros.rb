# frozen_string_literal: true

RSpec.shared_examples("a common error") do
  it "should have error array filled" do
    expect(graphql_errors).to_not(be_blank)
    expect(graphql_errors.first).to(have_key("message"))
  end
end

RSpec.shared_examples("not authenticated") do
  it "should have an unauthorized message" do
    unauthorized_message = I18n.t(:unauthorized, scope: [:errors, :messages])
    expect(graphql_errors.first["message"]).to(eq(unauthorized_message))
  end
end

RSpec.shared_examples("unauthorized") do |action|
  it "should have an unauthorized message" do
    error_message = I18n.t(
      :unauthorized_action,
      model: model.class.name,
      action: action,
      id: model.id,
      scope: [:errors, :messages],
    )
    expect(graphql_errors.first["message"]).to(eq(error_message))
  end
end
RSpec.shared_examples("unauthorized access level") do
  it "should have an unauthorized message" do
    error_message = I18n.t(:unauthorized_permission, scope: [:errors, :messages])
    expect(graphql_errors.first["message"]).to(eq(error_message))
  end
end
