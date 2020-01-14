# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::Auth::SignInMutation
    field :update_user_wallpaper, mutation: Mutations::UserWallpaper::UpdateUserWallpaper
    field :delete_user_wallpaper, mutation: Mutations::UserWallpaper::DeleteUserWallpaperMutation
    field :create_wallpaper, mutation: Mutations::UserWallpaper::CreateUserWallpaperMutation
    field :delete_user, mutation: Mutations::User::DeleteUserMutation
    field :update_user, mutation: Mutations::User::UpdateUserMutation
    field :sign_up, mutation: Mutations::Auth::SignUpMutation
  end
end
