module Types
  class DestinationType < Types::BaseObject
    field :destination, String, null: true
    field :num_saved_trips, Integer, null: true
  end
end
