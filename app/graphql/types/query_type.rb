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

    field :wallpapers, Types::UserWallpaper::WallpaperPaginatedType, "It will list all wallpapers and their owners", null: false do
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

    field :wallpaper, Types::UserWallpaper::WallpaperType, "It will filter and show an image by id", null: false do
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

    field :cart, Types::Cart::CartType, null: false, description: "It will return a cart structure"
    def cart
      check_authentication!
      ::Cart.where(user_id: context[:current_user], status: :created).first_or_create!
    rescue ActiveRecord::ActiveRecordError => invalid
      GraphQL::ExecutionError.new(invalid)
    end

    field :order, Types::Order::OrderType, null: false, description: "It will return a single order informations related to an user" do
      argument :order_id, ID, required: true
    end
    def order(order_id:)
      check_authentication!
      single_order = ::Order.find(order_id)
      authorize_show?(OrderPolicy, single_order)
      single_order
    end

    field :orders, Types::Order::OrdersPaginatedType, null: false, description: "It will return a list of all orders informations related to an user" do
      argument :pagination, Types::Inputs::PaginationInputType, required: true
    end
    def orders(pagination:)
      check_authentication!
      orders_paginated = context[:current_user].orders.page(pagination[:current_page]).per(pagination[:rows_per_page])
      {
        values: orders_paginated,
        paginate: {
          current_page: orders_paginated.current_page,
          rows_per_page: orders_paginated.limit_value,
          total_pages: orders_paginated.total_pages,
        },
      }
    end
  end
end
