require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'get trip' do
    before :each do
      @user = create(:user, :with_trips)
      @trip = @user.trips.first
      @photos = create_list(:photo, 3)
      @trip.photos << @photos
    end
      
    it 'can get trip and details by ID' do   
      post graphql_path, params: { query: query(id: @trip.id) }
      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:getTrip]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq(@trip.id.to_s)

      expect(data).to have_key(:userId)
      expect(data[:userId]).to eq(@user.id.to_s)

      expect(data).to have_key(:traveledTo)
      expect(data[:traveledTo]).to eq(true).or eq(false)

      expect(data).to have_key(:photos)
      expect(data[:photos]).to be_an(Array)
      expect(data[:photos].size).to eq(3)

      data[:photos].each do |photo|
        expect(photo).to have_key(:id)
        expect(photo[:id]).to be_a(String)
        expect(photo).to have_key(:url)
        expect(photo[:url]).to be_a(String)
        expect(photo).to have_key(:artistName)
        expect(photo[:artistName]).to be_a(String)
        expect(photo).to have_key(:artistProfile)
        expect(photo[:artistProfile]).to be_a(String)
        expect(photo).to have_key(:userUploaded)
        expect(photo[:userUploaded]).to eq(true).or eq(false)
        expect(photo).to have_key(:unsplashId)
        expect(photo[:unsplashId]).to be_a(String)
      end
    end

    it 'can get trip without photos by ID' do   
      post graphql_path, params: { query: query(id: @user.trips[1].id) }
      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:getTrip]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq(@user.trips[1].id.to_s)

      expect(data).to have_key(:userId)
      expect(data[:userId]).to eq(@user.id.to_s)

      expect(data).to have_key(:traveledTo)
      expect(data[:traveledTo]).to eq(true).or eq(false)

      expect(data).to have_key(:photos)
      expect(data[:photos]).to be_an(Array)
      expect(data[:photos].empty?).to eq(true)
    end

    def query(id:)
      <<~GQL
        {
          getTrip(id: "#{id}") {
            id
            name
            userId
            traveledTo
            photos {
              id
              url
              artistName
              artistProfile
              userUploaded
              unsplashId
            }
          }
        }
      GQL
    end
  end
end
