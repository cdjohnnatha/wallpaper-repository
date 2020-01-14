# frozen_string_literal: true
module Mutations
  module Auth
    class SignUpMutation < BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :auth_provider, Types::AuthProviderEmailInput, required: true

      field :user, Types::UserType, null: true
      field :token, String, null: true

      def resolve(args)
        params = args
        params[:email] = args[:auth_provider][:email]
        params[:password] = args[:auth_provider][:password]
        user = ::User.create!(params.except(:auth_provider))
        # current_user needs to be set so authenticationToken can be returned
        # context[:current_user] = user
        if user.valid?
          token = JWT.encode({ user_id: user.id }, ENV['SECRET_KEY_BASE'], 'HS256')
          { user: user, token: token }
        else
          GraphQL::ExecutionError.new(user.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => error
        GraphQL::ExecutionError.new(error)
      end
    end
  end
end
