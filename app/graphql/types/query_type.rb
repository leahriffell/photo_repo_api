module Types
  class QueryType < Types::BaseObject
    # Photos
    field :search_photos, [Types::PhotoType], null: false, description: 'Returns 10 photos that match a search term' do
      argument :keyword, String, required: true
    end
    field :get_photos, [Types::PhotoType], null: false,
                                           description: 'Returns all photos (user uploaded and saved from Unsplash'

    def search_photos(keyword:)
      PhotoFacade.get_photos(keyword)
    end

    def get_photos
      Photo.all.with_attached_user_photo
    end

    # Users
    field :get_users, [Types::UserType], null: false, description: 'Returns a list of all users'

    field :get_user, Types::UserType, null: false, description: 'Returns a user by user id' do
      argument :id, ID, required: true
    end

    def get_users
      User.all
    end

    def get_user(id:)
      User.find(id)
    end

    # Trips
    field :get_trip, Types::TripType, null: false, description: 'Returns a trip by trip id' do
      argument :id, ID, required: true
    end

    field :top_destinations, [Types::DestinationType], null: false,
                                                       description: 'Returns top destinations (most saved trips)' do
      argument :limit, Integer, required: false
    end

    def get_trip(id:)
      Trip.find(id)
    end

    def top_destinations(limit: Trip.count)
      Trip.top_trips(limit)
    end
  end
end
