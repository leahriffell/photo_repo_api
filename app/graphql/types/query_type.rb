module Types
  class QueryType < Types::BaseObject
    # Photos
    field :search_photos, [Types::PhotoType], null: false, description: 'Returns 10 photos that match a search term' do
      argument :keyword, String, required: true
    end

    def search_photos(keyword:)
      PhotoFacade.get_photos(keyword)
    end

    # Users
    field :get_users, [Types::UserType], null: false, description: 'Returns a list of all users'

    def get_users
      User.all
    end

    # Trips
    field :get_trip, Types::TripType, null: false, description: 'Returns a trip by trip id' do
      argument :id, ID, required: true
    end

    def get_trip(id:)
      Trip.find(id)
    end
  end
end
