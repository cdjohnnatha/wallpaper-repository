# frozen_string_literal: true
module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError, I18n.t(:unauthorized, scope: [:errors, :messages])
    end

    def has_admin_role?
      return if context[:current_user].admin?
      error_message = I18n.t(:unauthorized_permission, scope: [:errors, :messages])
      raise GraphQL::ExecutionError, error_message
    end

    def authorize_index?(policy, record)
      unless policy.new(context[:current_user], record).index?
        raise GraphQL::ExecutionError, I18n.t(
          :unauthorized_action,
          model: record.class.name,
          action: :index,
          id: record.id,
          scope: [:errors, :messages],
        )
      end
    end

    def authorize_show?(policy, record)
      unless policy.new(context[:current_user], record).show?
        raise GraphQL::ExecutionError, I18n.t(
          :unauthorized_action,
          model: record.class.name,
          action: :index,
          id: record.id,
          scope: [:errors, :messages],
        )
      end
    end
  end
end
