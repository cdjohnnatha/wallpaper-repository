module Types
  module Inputs
    class PaginationInputType < BaseInputObject
      argument :current_page, Int, required: true
      argument :rows_per_page, Int, required: true
    end
  end
end
