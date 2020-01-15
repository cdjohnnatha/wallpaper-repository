# frozen_string_literal: true
module Mutations
  module Category
    class DeleteCategoryMutation < BaseMutation
      argument :id, ID, required: true

      field :category, Types::Categories::CategoryType, null: false

      def resolve(args)
        check_authentication!
        has_admin_role?

        category = ::Category.find(args[:id])
        category = category.destroy
        if category.valid?
          { category: category }
        else
          GraphQL::ExecutionError.new(category.errors.full_messages)
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        GraphQL::ExecutionError.new(invalid)
      end
    end
  end
end
