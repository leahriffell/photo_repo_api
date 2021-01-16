module Types
  class MutationType < Types::BaseObject
    # Trips
    field :create_trip, mutation: Mutations::Trips::CreateTrip, description: 'Create a new trip'

    # Photos
    field :add_photo_to_trip, mutation: Mutations::Photos::AddPhotoToTrip, description: 'Add an Unsplash photo to a trip'
  end
end
