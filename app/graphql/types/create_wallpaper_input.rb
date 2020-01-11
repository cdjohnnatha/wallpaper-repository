# frozen_string_literal: true

module Types
  class CreateWallpaperInput < BaseInputObject
    argument :filename, String, required: true
    argument :file, ApolloUploadServer::Upload, required: true
  end
end