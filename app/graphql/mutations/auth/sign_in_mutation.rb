# frozen_string_literal: true
require 'jwt'

module Mutations
  module Auth
    class SignInMutation < BaseMutation
      argument :auth_provider, Types::AuthProviderEmailInput, required: true

      field :user, Types::UserType, null: false
      field :token, String, null: false
      def resolve(args)
        user = ::User.find_for_database_authentication(email: args[:auth_provider][:email])

        if user&.valid_password?(args[:auth_provider][:password])
          token = JWT.encode({ user_id: user.id }, ENV['SECRET_KEY_BASE'], 'HS256')
          { user: user, token: token }
        else
          GraphQL::ExecutionError.new(I18n.t(:invalid_email_password, scope: [:errors, :messages]))
        end
      rescue Pundit::NotAuthorizedError
        GraphQL::ExecutionError.new("Unauthorized: Show #{@model.name}")
      end
    end
  end
end
