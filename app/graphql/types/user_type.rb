# frozen_string_literal: true
module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false

    field :email, String, null: false

    field :full_name, String, null: false
    def full_name
      object.first_name.to_s + ' ' + object.last_name.to_s
    end
  end
end
