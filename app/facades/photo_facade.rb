class PhotoFacade
  def self.get_photos(location)
    PhotoService.search_photos(location)[:results].map { |result| PhotoDetails.new(result) }
  end
end
