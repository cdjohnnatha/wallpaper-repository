# frozen_string_literal: true

require "rails_helper"
# include ActionController::RespondWith

module RequestHelper
  def graphql_result
    result["data"]
  end
  # def authorization(user)
  #   auth_headers = user.create_new_auth_token
  #   # auth_headers["Accept"] = "application/vnd.api+json"
  #   # auth_headers["Content-Type"] = "application/vnd.api+json"
  #   auth_headers
  # end
end

RSpec.configure do |config|
  config.include(RequestHelper)
end
