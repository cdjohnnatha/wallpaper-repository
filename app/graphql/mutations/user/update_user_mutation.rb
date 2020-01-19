# frozen_string_literal: true
module Mutations
  module User
    class UpdateUserMutation < BaseMutation
      argument :email, String, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false

      field :user, Types::UserType, null: false

      def resolve(args)
        check_authentication!
        inputs = {}
        inputs[:email] = args[:email] unless args[:email].nil?
        inputs[:first_name] = args[:first_name] unless args[:first_name].nil?
        inputs[:last_name] = args[:last_name] unless args[:last_name].nil?

        if inputs.empty?
          return GraphQL::ExecutionError.new(I18n.t(:empty_attributes, model: :user, scope: [:errors, :messages]))
        end

        user = context[:current_user]
        user.update!(inputs.to_h)

        if user.valid?
          { user: user }
        else
          GraphQL::ExecutionError.new(user.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => error
        GraphQL::ExecutionError.new(error)
      end
    end
  end
end
