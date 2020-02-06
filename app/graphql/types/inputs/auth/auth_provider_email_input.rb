# frozen_string_literal: true
module Types
  module Inputs
    module Auth
      class AuthProviderEmailInput < Types::BaseInputObject
        argument :email, String, required: true
        argument :password, String, required: true
      end
    end
  end
end
