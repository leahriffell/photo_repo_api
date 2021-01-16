require 'rails_helper'

RSpec.describe Mutations::Photos::AddPhotoToTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user, :with_trips)
    end   

    it 'adds an Unsplash photo to a trip' do
      attributes = {
        tripId: @user.trips.first.id,
        url: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=1080',
        artistName: 'Jack Ward',
        artistProfile: 'https://unsplash.com/@jackward',
        unsplashId: 'rknrvCrfS1k'
      }

      post graphql_path, params: { query: query(attributes) }
      result = JSON.parse(response.body)

      expect(Photo.count).to eq(1)
      data = result['data']['addPhotoToTrip']
      expect(data['url']).to eq(attributes[:url])
      expect(data['artistName']).to eq(attributes[:artistName])
      expect(data['artistProfile']).to eq(attributes[:artistProfile])
      expect(data['unsplashId']).to eq(attributes[:unsplashId])
    end

    # add sad path for not passing in unsplash attrs 

    def query(attributes)
      <<~GQL
        mutation {
          addPhotoToTrip(input:{
              tripId: "#{attributes[:tripId]}"
              url: "#{attributes[:url]}"
              artistName: "#{attributes[:artistName]}"
              artistProfile: "#{attributes[:artistProfile]}"
              unsplashId: "#{attributes[:unsplashId]}"
              }) {
                url
                artistName
                artistProfile
                unsplashId
              }
            }
      GQL
    end
  end
end
