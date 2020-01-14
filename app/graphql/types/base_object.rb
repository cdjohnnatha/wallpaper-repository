# frozen_string_literal: true
module Types
  # include PunditIntegration
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    def authorize_index?(policy, record)
      unless policy.new(context[:current_user], record).index?
        raise GraphQL::ExecutionError, I18n.t(:unauthorized, model: record.class.name, action: :index, scope: [:errors, :messages])
      end
    end

    def authorize_show?(policy, record)
      unless policy.new(context[:current_user], record).show?
        raise GraphQL::ExecutionError, I18n.t(:unauthorized, model: record.class.name, action: :index, scope: [:errors, :messages])
      end
    end
  end
end
