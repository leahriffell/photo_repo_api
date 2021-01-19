module Mutations
  module Photos
    class AddUserPhotoToTrip < Mutations::BaseMutation
      include Rails.application.routes.url_helpers
      require 'uri'
      require 'open-uri'


      argument :trip_id, ID, required: true
      argument :user_photo, ApolloUploadServer::Upload, required: false

      type Types::PhotoType

      def resolve(attributes)
        blob = AddUserPhotoToTrip.upload_file(attributes[:user_photo])

        photo = Photo.create!(
          user_uploaded: true,
          user_photo: blob
        )

        PhotoTrip.create!(photo_id: photo.id, trip_id: attributes[:trip_id])
        photo
      end

      private

      def self.upload_file(file)
        ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end
    end
  end
end
