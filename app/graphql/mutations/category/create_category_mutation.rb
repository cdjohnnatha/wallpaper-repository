# frozen_string_literal: true
module Mutations
  module Category
    class CreateCategoryMutation < BaseMutation
      argument :name, String, required: true

      field :category, Types::Categories::CategoryType, null: false

      def resolve(args)
        check_authentication!
        has_admin_role?

        category = ::Category.create(args)

        if category.valid?
          { category: category }
        else
          GraphQL::ExecutionError.new(category.errors.full_messages)
        end
      end
    end
  end
end
