module Types
  class QueryType < Types::BaseObject
    field :search_photos, [Types::PhotoType], null: false, description: 'Returns 10 photos that match a search term' do
      argument :keyword, String, required: true
    end

    field :get_users, [Types::UserType], null: false, description: 'Returns a list of all users'

    # Photos
    def search_photos(keyword:)
      PhotoFacade.get_photos(keyword)
    end

    # Users
    def get_users
      User.all
    end
  end
end
