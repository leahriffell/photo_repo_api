require 'rails_helper'

RSpec.describe Mutations::Trips::CreateTrip, type: :request do
  describe '.resolve' do
    before :each do
      @user = create(:user)
    end

    it 'creates a trip' do
      attributes = {
        userId: @user.id,
        name: 'Caye Caulker, Belize',
        traveledTo: false
      }

      post graphql_path, params: { query: query(attributes) }
      result = JSON.parse(response.body)

      expect(Trip.count).to eq(1)
      data = result['data']['createTrip']
      expect(data['userId']).to eq(@user.id.to_s)
      expect(data['name']).to eq(attributes[:name])
      expect(data['traveledTo']).to eq(attributes[:traveledTo])
    end

    def query(attributes)
      <<~GQL
        mutation {
          createTrip(input:{
              userId: "#{attributes[:userId]}"
              name: "#{attributes[:name]}"
              traveledTo: #{attributes[:traveledTo]}
              }) {
                id
                userId
                name
                traveledTo
              }
            }
      GQL
    end
  end
end
