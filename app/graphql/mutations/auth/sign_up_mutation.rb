# frozen_string_literal: true
module Mutations
  module Auth
    class SignUpMutation < BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :auth_provider, Types::AuthProviderEmailInput, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: true

      def resolve(args)
        user = ::User.create!(
          first_name: args[:first_name],
          last_name: args[:last_name],
          email: args[:auth_provider][:email],
          password: args[:auth_provider][:password]
        )
        # current_user needs to be set so authenticationToken can be returned
        # context[:current_user] = user
        if user.valid?
          { user: user, erros: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
