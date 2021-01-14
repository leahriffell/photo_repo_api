class PhotoDetails
  attr_reader :description,
              :url,
              :artist_name,
              :artist_profile

  def initialize(details)
    @description = details[:description]
    @url = details[:urls][:regular]
    @artist_name = details[:user][:name]
    @artist_profile = details[:user][:links][:html]
  end
end
