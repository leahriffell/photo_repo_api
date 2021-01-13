module Types
  class QueryType < Types::BaseObject
    field :search_photos, [Types::PhotoType], null: false, description: 'Returns 10 photos that match a search term' do
      argument :keyword, String, required: true
    end

    def search_photos(keyword:)
      PhotoFacade.get_photos(keyword)
    end
  end
end
