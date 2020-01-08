# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    field :delete_user, mutation: Mutations::User::DeleteUserMutation
    field :update_user, mutation: Mutations::User::UpdateUserMutation
    field :sign_up, mutation: Mutations::Auth::SignUpMutation
  end
end
