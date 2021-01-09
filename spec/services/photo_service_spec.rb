require 'rails_helper'

RSpec.describe PhotoService do
  describe 'happy paths' do
    it 'can fetch photos by query keyword' do
      VCR.use_cassette('photos_italy') do
        response = PhotoService.search_images('Italy')
        photo_search_response_structure(response)
      end
    end

    it 'can fetch photos for query with 2 keywords' do
      VCR.use_cassette('photos_UK') do
        response = PhotoService.search_images('United Kingdom')
        photo_search_response_structure(response)
      end
    end
  end

  describe 'sad paths' do
    it 'returns no matching photos' do
      VCR.use_cassette('photos_no_results') do
        response = PhotoService.search_images('abcdefgh')
        expect(response).to be_a(Hash)

        expect(response).to have_key(:total)
        expect(response[:total]).to eq(0)

        expect(response).to have_key(:total_pages)
        expect(response[:total_pages]).to eq(0)

        expect(response).to have_key(:results)
        expect(response[:results]).to eq([])
      end
    end
  end
end
