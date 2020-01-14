# frozen_string_literal: true
require 'jwt'

class JsonWebToken
  def self.encode(param)
    JWT.encode(param, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  rescue JWT::DecodeError
    raise GraphQL::ExecutionError, 'invalid token'
  end
end
