module Types
  class PhotoType < Types::BaseObject
    field :description, String, null: true
    field :url, String, null: false
    field :artist_name, String, null: false
    field :artist_profile, String, null: false
  end
end
