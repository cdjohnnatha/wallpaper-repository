# frozen_string_literal: true
module Mutations
  module User
    class DeleteUserMutation < BaseMutation
      field :user, Types::UserType, null: false
      def resolve
        check_authentication!
        user = context[:current_user]
        user = user.destroy(id)
        if user
          { user: user }
        else
          GraphQL::ExecutionError.new(user.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
