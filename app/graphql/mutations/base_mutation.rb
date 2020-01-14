# frozen_string_literal: true
module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError, "You are unauthorized"
    end

    def authorize_create?(policy, record)
      unless policy.new(context[:current_user], record).create?
        raise GraphQL::ExecutionError, I18n.t(:unauthorized, model: record.class.name, action: :create, scope: [:errors, :messages])
      end
    end

    def authorize_update?(policy, record)
      unless policy.new(context[:current_user], record).update?
        raise GraphQL::ExecutionError, I18n.t(:unauthorized, model: record.class.name, action: :update, scope: [:errors, :messages])
      end
    end

    def authorize_destroy?(policy, record)
      unless policy.new(context[:current_user], record).destroy?
        raise GraphQL::ExecutionError, I18n.t(:unauthorized, model: record.class.name, action: :delete, scope: [:errors, :messages])
      end
    end
  end
end
