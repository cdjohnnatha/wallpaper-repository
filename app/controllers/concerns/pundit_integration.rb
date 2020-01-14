module PunditIntegration
  extend ActiveSupport::Concern

  included do
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