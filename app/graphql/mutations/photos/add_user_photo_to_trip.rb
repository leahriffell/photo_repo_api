module Mutations
  module Photos
    class AddUserPhotoToTrip < Mutations::BaseMutation
      argument :trip_id, ID, required: true
      argument :url, String, required: true

      type Types::PhotoType

      def resolve(attributes)
        attributes[:user_uploaded] = true
        photo = Photo.create!(attributes.except(:trip_id))
        PhotoTrip.create!(photo_id: photo.id, trip_id: attributes[:trip_id])
        photo
      end
    end
  end
end
