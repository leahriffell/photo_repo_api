require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'search photos' do
    it 'can query up to 10 images by search keyword(s)' do   
      VCR.use_cassette('photos_tokyo') do   
        post graphql_path, params: { query: query(keyword: 'tokyo') }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data][:searchPhotos].size).to eq(10)

        result[:data][:searchPhotos].each do |result|
          expect(result).to have_key(:description)
          expect(result).to have_key(:url)
          expect(result).to have_key(:artistName)
          expect(result).to have_key(:artistProfile)
        end
      end
    end

    it 'can query when search keyword(s) produce no results' do   
      VCR.use_cassette('photos_no_results') do   
        post graphql_path, params: { query: query(keyword: 'abcdefgh') }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result[:data][:searchPhotos].size).to eq(0)
      end
    end
  end

  def query(keyword:)
    <<~GQL
      {
        searchPhotos(keyword: "#{keyword}") {
          description
          url
          artistName
          artistProfile
        }
      }
    GQL
  end
end
