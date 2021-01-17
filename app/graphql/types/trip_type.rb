module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :destination, String, null: true
    field :traveled_to, Boolean, null: false
    field :photos, [Types::PhotoType], null: false
    field :latitude, Float, null: true
    field :longitude, Float, null: true
  end
end
