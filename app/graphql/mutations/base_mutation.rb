# frozen_string_literal: true
module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError.new(
        I18n.t(:unauthorized, scope: [:errors, :messages]),
        extensions: { code: 401 }
      )
    end

    def has_admin_role?
      return if context[:current_user].admin?
      error_message = I18n.t(:unauthorized_permission, scope: [:errors, :messages])
      raise GraphQL::ExecutionError, error_message
    end

    def authorize_create?(policy, record)
      unless policy.new(context[:current_user], record).create?
        raise GraphQL::ExecutionError, I18n.t(
          :unauthorized,
          model: record.class.name,
          action: :create,
          scope: [:errors, :messages],
        )
      end
    end

    def authorize_update?(policy, record)
      unless policy.new(context[:current_user], record).update?
        raise GraphQL::ExecutionError, I18n.t(
          :unauthorized,
          model: record.class.name,
          action: :update,
          scope: [:errors, :messages],
        )
      end
    end

    def authorize_destroy?(policy, record)
      unless policy.new(context[:current_user], record).destroy?
        raise GraphQL::ExecutionError, I18n.t(
          :unauthorized_to_destroy_item,
          model: record.class.name,
          id: record.id,
          action: :delete,
          scope: [:errors, :messages],
        )
      end
    end
  end
end
