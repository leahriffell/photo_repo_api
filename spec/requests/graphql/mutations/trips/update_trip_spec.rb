require 'rails_helper'

RSpec.describe Mutations::Trips::UpdateTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user)
      @user = create(:user, :with_trips)
      @trip = @user.trips.first

      @attributes = {
        destination: 'Ottawa, Canada',
        traveledTo: true
      }
    end

    it 'updates a trip' do
      post graphql_path, params: { query: query(@trip.id) }
      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:updateTrip]

      expect(data[:id]).to eq(@trip.id.to_s)
      expect(data[:userId]).to eq(@user.id.to_s)
      expect(data[:destination]).to eq(@attributes[:destination])
      expect(data[:traveledTo]).to eq(@attributes[:traveledTo])
    end

    def query(id)
      <<~GQL
        mutation {
          updateTrip(input:{
              id: #{id}
              destination: "#{@attributes[:destination]}"
              traveledTo: #{@attributes[:traveledTo]}
              }) {
                id
                userId
                destination
                traveledTo
              }
            }
      GQL
    end
  end
end
