module Types
  class PhotoType < Types::BaseObject
    include Rails.application.routes.url_helpers

    field :id, ID, null: false
    field :description, String, null: true
    field :url, String, null: true
    field :artist_name, String, null: true
    field :artist_profile, String, null: true
    field :unsplash_id, String, null: true
    field :user_uploaded, Boolean, null: false
    field :user_photo_url, String, null: true

    def user_photo_url
      Cloudinary::Utils.cloudinary_url(object.user_photo.blob.key) if object.user_photo.attached?
    end
  end
end
