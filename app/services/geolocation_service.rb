class GeolocationService
  def self.forward_geocode(destination)
    response = conn.get("/geocoding/v1/address?") do |request|
      request.params['key'] = ENV['GEOLOCATION_API_KEY']
      request.params['location'] = destination
    end
    parsed = parse(response)
    parse_lat_lng(parsed)
  end

  private
  
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.parse_lat_lng(response)
    if response[:results][0][:locations].empty?
      {lat: nil, lng: nil}
    else
      response[:results][0][:locations][0][:latLng]
    end
  end
end
