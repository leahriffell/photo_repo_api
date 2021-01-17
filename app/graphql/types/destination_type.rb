module Types
  class DestinationType < Types::BaseObject
    field :destination, String, null: false
    field :num_saved_trips, Integer, null: false
  end
end
