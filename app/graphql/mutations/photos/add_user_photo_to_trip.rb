module Mutations
  module Photos
    class AddUserPhotoToTrip < Mutations::BaseMutation
      include Rails.application.routes.url_helpers

      argument :trip_id, ID, required: true
      argument :user_photo, ApolloUploadServer::Upload, required: false

      type Types::PhotoType

      def resolve(attributes)
        file = attributes[:user_photo]
        blob = ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )

        photo = Photo.create!(
          user_uploaded: true,
          user_photo: blob
        )

        PhotoTrip.create!(photo_id: photo.id, trip_id: attributes[:trip_id])
        photo.user_photo_url = (rails_blob_path(photo.user_photo, only_path: true) if photo.user_photo.attached?)

        photo
      end
    end
  end
end
