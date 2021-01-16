require 'rails_helper'

RSpec.describe Mutations::Photos::AddUserPhotoToTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user, :with_trips)

      @attributes = {
        tripId: @user.trips.first.id,
        url: 'https://im-media.voltron.voanews.com/Drupal/01live-166/styles/sourced/s3/2019-04/CB37C5C5-0852-4D87-A5F2-9E07BA031B95.jpg?itok=D95QwOUK'
      }
    end   

    it 'creates a photo and adds to a trip' do
      post graphql_path, params: { query: query(@attributes) }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(Photo.count).to eq(1)
      expect(PhotoTrip.count).to eq(1)
      expect(PhotoTrip.first.photo_id).to eq(Photo.first.id)
      expect(PhotoTrip.first.trip_id).to eq(@user.trips.first.id)

      data = result[:data][:addUserPhotoToTrip]

      expect(data[:url]).to eq(@attributes[:url])
      expect(data[:artistName]).to eq(nil)
      expect(data[:artistProfile]).to eq(nil)
      expect(data[:unsplashId]).to eq(nil)
      expect(data[:userUploaded]).to eq(true)
    end

    def query(attributes)
      <<~GQL
        mutation {
          addUserPhotoToTrip(input:{
              tripId: "#{@attributes[:tripId]}"
              url: "#{@attributes[:url]}"
              }) {
                url
                artistName
                artistProfile
                unsplashId
                userUploaded
              }
            }
      GQL
    end
  end
end
