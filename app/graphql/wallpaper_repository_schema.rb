# frozen_string_literal: true

class WallpaperRepositorySchema < GraphQL::Schema
  include(ExceptionHandler)
  mutation(Types::MutationType)
  query(Types::QueryType)
end
