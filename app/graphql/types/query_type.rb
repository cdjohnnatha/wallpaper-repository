# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    field :list_users, [Types::UserType], null: false,
      description: "An example field added by the generator"
    def list_users
      check_authentication!
      has_admin_role?
      User.all
    end

    field :profile, Types::UserType, null: false,
      description: "It will show all informations related to a logged user"
    def profile
      check_authentication!
      context[:current_user]
    end

    field :wallpapers, Types::WallpaperPaginatedType, "It will list all wallpapers and their owners", null: false do
      argument :pagination, Types::Inputs::PaginationInputType, required: true
    end
    def wallpapers(pagination:)
      wallpapers = Wallpaper.page(pagination[:current_page]).per(pagination[:rows_per_page])

      {
        values: wallpapers,
        paginate: {
          current_page: wallpapers.current_page,
          rows_per_page: wallpapers.limit_value,
          total_pages: wallpapers.total_pages,
        },
      }
    end

    field :wallpaper, Types::WallpaperType, "It will filter and show an image by id", null: false do
      argument :wallpaper_id, ID, required: true
    end
    def wallpaper(wallpaper_id:)
      Wallpaper.find(wallpaper_id)
    end

    field :categories, Types::Categories::CategoryPaginatedType, "It will return a list of categories", null: false do
      argument :pagination, Types::Inputs::PaginationInputType, required: true
    end
    def categories(pagination:)
      categories = Category.page(pagination[:current_page]).per(pagination[:rows_per_page])

      {
        values: categories,
        paginate: {
          current_page: categories.current_page,
          rows_per_page: categories.limit_value,
          total_pages: categories.total_pages,
        },
      }
    end
  end
end
