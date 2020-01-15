# frozen_string_literal: true
module Types
  module Categories
    class CategoryPaginatedType < Types::BaseObject
      field :paginate, Types::PaginationType, null: false
      field :values, [CategoryType], null: false
    end
  end
end
