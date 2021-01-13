class PhotoFacade
  def self.get_photos(location)
    PhotoService.search_photos(location)[:results].map { |result| Photo.new(result) }
  end
end
