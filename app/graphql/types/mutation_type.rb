module Types
  class MutationType < Types::BaseObject
    field :create_trip, mutation: Mutations::Trips::CreateTrip, description: 'Create a new trip'
  end
end
