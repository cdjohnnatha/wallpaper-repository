module Types
  class WallpaperType < Types::BaseObject
    field :id, ID, null: false
    field :filename, String, null: false
    field :price, Float, null: false
    field :quantity, Int, null: false
  end
end