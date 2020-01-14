# frozen_string_literal: true

require "rails_helper"
require 'jwt'
# include ActionController::RespondWith

module RequestHelper
  def graphql_result
    result["data"]
  end

  def graphql_response
    JSON.parse(response.body)['data']
  end

  def graphql_errors
    JSON.parse(response.body)['errors']
  end

  def authenticated_header(user)
    token = JWT.encode({ user_id: user.id }, ENV['SECRET_KEY_BASE'], 'HS256')
    { "Authorization": "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include(RequestHelper)
end
