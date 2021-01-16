module Mutations
  module Photos
    class AddPhotoToTrip < Mutations::BaseMutation
      argument :trip_id, ID, required: true
      argument :url, String, required: true
      argument :artist_name, String, required: true
      argument :artist_profile, String, required: true
      argument :unsplash_id, String, required: true

      type Types::PhotoType

      def resolve(attributes)
        attributes[:user_uploaded] = false
        Photo.create!(attributes.except(:trip_id)) unless Photo.find_by(unsplash_id: attributes[:unsplash_id])
        photo = Photo.find_by(unsplash_id: attributes[:unsplash_id])
        PhotoTrip.create!(photo_id: photo.id, trip_id: attributes[:trip_id])
        photo
        # add photo to db if it doesn't yet exist
        # set user uploaded to false
        # create new trip_photo
      end
    end
  end
end
