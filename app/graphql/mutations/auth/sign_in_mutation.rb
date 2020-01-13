module Mutations
  module Auth
    class SignInMutation < BaseMutation
      argument :auth_provider, Types::AuthProviderEmailInput, required: true

      field :user, Types::UserType, null: false
      def resolve(args)
        user = ::User.find_for_database_authentication(email: args[:auth_provider][:email])

        if user && user.valid_password?(args[:auth_provider][:password])
          # token = user.authentication_token
          # raise token.inspect
          { user: user }
        end
        # raise user.inspect
      end
    end
  end
end
