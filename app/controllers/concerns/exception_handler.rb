# frozen_string_literal: true

module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      GraphQL::ExecutionError.new(e)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      GraphQL::ExecutionError.new(e)
    end
  end
end