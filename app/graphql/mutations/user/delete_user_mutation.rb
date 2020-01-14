# frozen_string_literal: true
module Mutations
  module User
    class DeleteUserMutation < BaseMutation
      argument :confirm_password, String, required: false

      field :user, Types::UserType, null: false
      def resolve(args)
        check_authentication!
        user = context[:current_user]
        if user&.valid_password?(args[:confirm_password])
          user = user.destroy
          if user
            { user: user }
          else
            GraphQL::ExecutionError.new(user.errors.full_messages)
          end
        else
          GraphQL::ExecutionError.new('Invalid password')
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
