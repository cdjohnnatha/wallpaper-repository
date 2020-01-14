# frozen_string_literal: true
module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

   include PunditIntegration
    def check_authentication!
      return if context[:current_user]

      raise GraphQL::ExecutionError, "You are unauthorized"
    end
  end
end
