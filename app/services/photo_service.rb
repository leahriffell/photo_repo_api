class PhotoService
  def self.search_images(search_query)
    response = conn.get do |request|
      request.headers['Accept-Version'] = 'v1'
      request.params['client_id'] = ENV['PHOTOS_API_KEY']
      request.params['query'] = search_query
      request.params['per_page'] = 10
    end
    parse(response)
  end

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com/search/photos?')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
