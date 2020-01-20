# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    field :purchase_cart, mutation: Mutations::Cart::PurchaseCartMutation
    field :delete_cart_item, mutation: Mutations::Cart::DeleteCartItemMutation
    field :add_cart_items, mutation: Mutations::Cart::AddCartItemMutation
    field :delete_category, mutation: Mutations::Category::DeleteCategoryMutation
    field :update_category, mutation: Mutations::Category::UpdateCategoryMutation
    field :create_category, mutation: Mutations::Category::CreateCategoryMutation
    field :sign_in, mutation: Mutations::Auth::SignInMutation
    field :update_user_wallpaper, mutation: Mutations::UserWallpaper::UpdateUserWallpaper
    field :delete_user_wallpaper, mutation: Mutations::UserWallpaper::DeleteUserWallpaperMutation
    field :create_wallpaper, mutation: Mutations::UserWallpaper::CreateUserWallpaperMutation
    field :delete_user, mutation: Mutations::User::DeleteUserMutation
    field :update_user, mutation: Mutations::User::UpdateUserMutation
    field :sign_up, mutation: Mutations::Auth::SignUpMutation
  end
end
