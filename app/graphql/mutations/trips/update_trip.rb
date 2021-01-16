module Mutations
  module Trips
    class UpdateTrip < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :traveled_to, Boolean, required: false

      type Types::TripType

      def resolve(attributes)
        Trip.find(attributes[:id]).update!(attributes)
        Trip.find(attributes[:id])
      end
    end
  end
end
