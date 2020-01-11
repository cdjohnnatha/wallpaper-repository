# frozen_string_literal: true
module Mutations
  module User
    class UpdateUserMutation < BaseMutation
      argument :email, String, required: false
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :id, ID, required: true

      field :user, Types::UserType, null: false

      def resolve(args)
        inputs = {}
        inputs[:email] = args[:email] unless args[:email].nil?
        inputs[:first_name] = args[:first_name] unless args[:first_name].nil?
        inputs[:last_name] = args[:last_name] unless args[:last_name].nil?

        if inputs.empty?
          return GraphQL::ExecutionError.new(I18n.t(:empty_attributes, model: :user, scope: [:errors, :messages]))
        end

        user = ::User.find_by(id: args[:id])
        user.update!(inputs.to_h)

        if user.valid?
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
