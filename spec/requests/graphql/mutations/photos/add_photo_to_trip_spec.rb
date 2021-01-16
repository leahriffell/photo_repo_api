require 'rails_helper'

RSpec.describe Mutations::Photos::AddPhotoToTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user, :with_trips)

      @attributes = {
        tripId: @user.trips.first.id,
        url: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=1080',
        artistName: 'Jack Ward',
        artistProfile: 'https://unsplash.com/@jackward',
        unsplashId: 'rknrvCrfS1k'
      }
    end   

    it 'creates an Unsplash photo and adds to a trip' do
      post graphql_path, params: { query: query(@attributes) }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Photo.count).to eq(1)
      expect(PhotoTrip.count).to eq(1)
      expect(PhotoTrip.first.photo_id).to eq(Photo.first.id)
      expect(PhotoTrip.first.trip_id).to eq(@user.trips.first.id)

      data = result[:data][:addPhotoToTrip]
      expect(data[:url]).to eq(@attributes[:url])
      expect(data[:artistName]).to eq(@attributes[:artistName])
      expect(data[:artistProfile]).to eq(@attributes[:artistProfile])
      expect(data[:unsplashId]).to eq(@attributes[:unsplashId])
    end

    it 'does not create an Unsplash photo without attribution' do
      post '/graphql', params: { query:
        <<~GQL
        mutation {
          addPhotoToTrip(input: {
            tripId: #{@user.trips.first.id}
            url: "#{@attributes[:url]}"
            unsplashId: "#{@attributes[:unsplashId]}"
            }) {
              url
              artistName
              artistProfile
              unsplashId
            }
          }
        GQL
      }

      expect(Photo.count).to eq(0)
      expect(PhotoTrip.count).to eq(0)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:errors][0][:message]).to eq("Argument 'artistName' on InputObject 'AddPhotoToTripInput' is required. Expected type String!")
      expect(result[:errors][1][:message]).to eq("Argument 'artistProfile' on InputObject 'AddPhotoToTripInput' is required. Expected type String!")
    end

    it 'does not create an Unsplash photo without an Unsplash ID' do
      post '/graphql', params: { query:
        <<~GQL
        mutation {
          addPhotoToTrip(input: {
            tripId: #{@user.trips.first.id}
            url: "#{@attributes[:url]}"
            artistName: "#{@attributes[:artistName]}"
            artistProfile: "#{@attributes[:artistProfile]}"
            }) {
              url
              artistName
              artistProfile
              unsplashId
            }
          }
        GQL
      }

      expect(Photo.count).to eq(0)
      expect(PhotoTrip.count).to eq(0)

      result = JSON.parse(response.body, symbolize_names: true)
    
      expect(result[:errors][0][:message]).to eq("Argument 'unsplashId' on InputObject 'AddPhotoToTripInput' is required. Expected type String!")
    end

    def query(attributes)
      <<~GQL
        mutation {
          addPhotoToTrip(input:{
              tripId: "#{@attributes[:tripId]}"
              url: "#{@attributes[:url]}"
              artistName: "#{@attributes[:artistName]}"
              artistProfile: "#{@attributes[:artistProfile]}"
              unsplashId: "#{@attributes[:unsplashId]}"
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
