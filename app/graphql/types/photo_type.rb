module Types
  class PhotoType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: true
    field :url, String, null: false
    field :artist_name, String, null: true
    field :artist_profile, String, null: true
    field :unsplash_id, String, null: true
    field :user_uploaded, Boolean, null: false
  end
end
