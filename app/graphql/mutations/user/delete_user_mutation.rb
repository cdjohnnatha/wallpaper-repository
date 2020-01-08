# frozen_string_literal: true
module Mutations
  module User
    class DeleteUserMutation < BaseMutation
      argument :id, ID, required: true
      field :errors, [String], null: false
      field :user, Types::UserType, null: false
      def resolve(id:)
        user = ::User.destroy(id)
        if user
          { user: user, errors: nil }
        else user
             { user: user, errors: user.errors.full_messages }
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
