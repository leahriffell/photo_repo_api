require 'rails_helper'

RSpec.describe 'Photo Facade' do
  it 'returns photo poros when given a search query' do
    VCR.use_cassette('photos_italy') do
      photos = PhotoFacade.get_photos('Italy')

      photos.each do |photo|
        expect(photo).to be_a(PhotoDetails)
        expect(photo.description).to be_a(String).or eq(nil)
        expect(photo.url).to be_a(String)
        expect(photo.artist_name).to be_a(String)
        expect(photo.artist_profile).to be_a(String)
      end
    end
  end

  it 'returns no results when no matching photos found' do
    VCR.use_cassette('photos_no_results') do
      photos = PhotoFacade.get_photos('abcdefgh')

      expect(photos).to eq([])
    end
  end
end
