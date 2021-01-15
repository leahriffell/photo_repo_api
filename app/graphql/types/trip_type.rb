module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :name, String, null: true
    field :traveled_to, Boolean, null: false
  end
end
