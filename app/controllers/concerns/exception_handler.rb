# frozen_string_literal: true

module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from(ActiveRecord::RecordNotFound) do |error|
      GraphQL::ExecutionError.new(error)
    end

    rescue_from(ActiveRecord::RecordInvalid) do |error|
      GraphQL::ExecutionError.new(error)
    end

    rescue_from(ActiveRecord::ActiveRecordError) do |error|
      GraphQL::ExecutionError.new(error)
    end

    rescue_from(StandardError) do |message|
      GraphQL::ExecutionError.new(message, extensions: {code: 'INTERNAL_SERVER_ERROR'})
    end
  end
end
