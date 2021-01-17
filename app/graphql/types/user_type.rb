module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :photos, [Types::PhotoType], null: false
    field :trips, [Types::TripType], null: false
  end
end
