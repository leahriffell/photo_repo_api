module Mutations
  module Trips
    class CreateTrip < Mutations::BaseMutation
      argument :user_id, ID, required: true
      argument :destination, String, required: false
      argument :traveled_to, Boolean, required: false

      type Types::TripType

      def resolve(attributes)
        latlng = GeolocationService.forward_geocode(attributes[:destination])
        attributes[:latitude] = latlng[:lat]
        attributes[:longitude] = latlng[:lng]
        Trip.create!(attributes)
      end
    end
  end
end
