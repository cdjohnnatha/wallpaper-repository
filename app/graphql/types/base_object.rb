# frozen_string_literal: true
module Types
  include PunditIntegration
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField
  end
end
