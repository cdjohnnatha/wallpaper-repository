CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0700
  config.storage = :file
  # It configures to save the images at root folder.
  config.root = Rails.root
end