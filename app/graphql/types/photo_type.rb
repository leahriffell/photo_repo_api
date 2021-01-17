module Types
  class PhotoType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: true
    field :url, String, null: true
    field :artist_name, String, null: true
    field :artist_profile, String, null: true
    field :unsplash_id, String, null: true
    field :user_uploaded, Boolean, null: false
    field :user_photo_url, String, null: true
  end
end
