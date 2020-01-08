# frozen_string_literal: true
class WallpaperRepositorySchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
