require 'rails_helper'

RSpec.describe Mutations::Photos::AddUserPhotoToTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user, :with_trips)
      file = file_fixture('shinjuku.png')

      @attributes = {
        tripId: @user.trips.first.id,
        userPhoto: file
      }
    end   

    xit 'can upload a photo and add to a trip' do
      # File is sending as a string so .original_filename and content_type are nil. Research how to test as actual upload
      post graphql_path, params: { query: query(@attributes) }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Photo.count).to eq(1)
      expect(PhotoTrip.count).to eq(1)
      expect(PhotoTrip.first.photo_id).to eq(Photo.first.id)
      expect(PhotoTrip.first.trip_id).to eq(@user.trips.first.id)

      data = result[:data][:addUserPhotoToTrip]

      expect(data[:url]).to eq(nil)
      expect(data[:artistName]).to eq(nil)
      expect(data[:artistProfile]).to eq(nil)
      expect(data[:unsplashId]).to eq(nil)
      expect(data[:userUploaded]).to eq(true)
      expect(data[:userPhotoUrl]).to eq('inserturl')
    end
      
    def query(attributes)
      <<~GQL
        mutation {
          addUserPhotoToTrip(input:{
              tripId: "#{@attributes[:tripId]}"
              userPhoto: "#{@attributes[:userPhoto]}"
              }) {
                url
                artistName
                artistProfile
                unsplashId
                userUploaded
                userPhotoUrl
              }
            }
      GQL
    end
  end
end
