require 'jwt'

# frozen_string_literal: true
class GraphqlController < ApplicationController
  include Pundit
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  protect_from_forgery with: :null_session

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: current_user,
      pundit: self,
    }
    result = WallpaperRepositorySchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name,
    )
    render(json: result)
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    return nil if header.blank?
    header.gsub(pattern, '') if header&.match(pattern)
  end

  def current_user
    if bearer_token
      decoded_token = JWT.decode(bearer_token, nil, false).first
      User.find(decoded_token["user_id"])
    end
  rescue JWT::VerificationError, JWT::DecodeError
    raise GraphQL::ExecutionError, "Invalid token"
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))

    render(json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500)
  end
end
