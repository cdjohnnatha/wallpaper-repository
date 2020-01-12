module Types
  class PaginationType < BaseObject
    field :total_pages, Int, null: false
    field :current_page, Int, null: false
    field :rows_per_page, Int, null: false
  end
end
