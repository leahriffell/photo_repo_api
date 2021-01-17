require 'rails_helper'

RSpec.describe Mutations::Trips::CreateTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user)
    end

    it 'creates a trip' do
      VCR.use_cassette('geocode_caye_caulker') do
        attributes = {
          userId: @user.id,
          destination: 'Caye Caulker, Belize',
          traveledTo: false
        }

        post graphql_path, params: { query: query(attributes) }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(Trip.count).to eq(1)
        data = result[:data][:createTrip]

        expect(data[:userId]).to eq(@user.id.to_s)
        expect(data[:destination]).to eq(attributes[:destination])
        expect(data[:traveledTo]).to eq(attributes[:traveledTo])
        expect(data[:latitude]).to eq(17.62462)
        expect(data[:longitude]).to eq(-88.10969)
      end
    end

    it 'creates a trip without matching lat and lng coordinates' do
      VCR.use_cassette('geocode_no_match') do
        attributes = {
          userId: @user.id,
          destination: 'abcdefghijklmnop',
          traveledTo: false
        }

        post graphql_path, params: { query: query(attributes) }
        result = JSON.parse(response.body, symbolize_names: true)

        expect(Trip.count).to eq(1)
        data = result[:data][:createTrip]

        expect(data[:userId]).to eq(@user.id.to_s)
        expect(data[:destination]).to eq(attributes[:destination])
        expect(data[:traveledTo]).to eq(attributes[:traveledTo])
        expect(data[:latitude]).to eq(nil)
        expect(data[:longitude]).to eq(nil)
      end
    end

    def query(attributes)
      <<~GQL
        mutation {
          createTrip(input:{
              userId: "#{attributes[:userId]}"
              destination: "#{attributes[:destination]}"
              traveledTo: #{attributes[:traveledTo]}
              }) {
                id
                userId
                destination
                traveledTo
                latitude
                longitude
              }
            }
      GQL
    end
  end
end
