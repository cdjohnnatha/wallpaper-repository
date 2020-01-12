module Types
  class WallpaperPaginatedType < Types::BaseObject
    field :paginate, Types::PaginationType, null: false
    field :values, [Types::WallpaperType], null: false
  end
end
