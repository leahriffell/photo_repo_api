require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'top_destinations (aka most saved trip destinations)' do
    before :each do
      10.times { create(:trip, destination: 'Paris') }
      7.times { create(:trip, destination: 'Spain') }
      5.times { create(:trip, destination: 'Da Nang, Vietnam') }
      3.times { create(:trip, destination: 'Ubud, Bali') }
      15.times { create(:trip, destination: 'Tokyo') }
      2.times { create(:trip, destination: 'Denver, Colorado') } 
      2.times { create(:trip, destination: 'Middlebury, Indiana') } 
    end
      
    it 'can get ranked destinations when no limit is provided' do   
      post '/graphql', params: { query:
        <<~GQL
          query {
            topDestinations {
                destination
                numSavedTrips
              }
            }
          GQL
        }

      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:topDestinations]

      expect(data.size).to eq(7)

      expect(data[0][:destination]).to eq("Tokyo")
      expect(data[0][:numSavedTrips]).to eq(15)

      expect(data[1][:destination]).to eq("Paris")
      expect(data[1][:numSavedTrips]).to eq(10)

      expect(data[2][:destination]).to eq("Spain")
      expect(data[2][:numSavedTrips]).to eq(7)

      expect(data[3][:destination]).to eq("Da Nang, Vietnam")
      expect(data[3][:numSavedTrips]).to eq(5)

      expect(data[4][:destination]).to eq("Ubud, Bali")
      expect(data[4][:numSavedTrips]).to eq(3)

      expect(data[5][:destination]).to eq("Denver, Colorado")
      expect(data[5][:numSavedTrips]).to eq(2)

      expect(data[6][:destination]).to eq("Middlebury, Indiana")
      expect(data[6][:numSavedTrips]).to eq(2)
    end

    it 'can get top num destinations when limit is provided' do   
      post '/graphql',  params: { query: query(limit: 3) }

      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:topDestinations]

      expect(data.size).to eq(3)

      expect(data[0][:destination]).to eq("Tokyo")
      expect(data[0][:numSavedTrips]).to eq(15)

      expect(data[1][:destination]).to eq("Paris")
      expect(data[1][:numSavedTrips]).to eq(10)

      expect(data[2][:destination]).to eq("Spain")
      expect(data[2][:numSavedTrips]).to eq(7)
    end

    def query(limit:)
      <<~GQL
        {
          topDestinations(limit: #{limit}) {
            destination
            numSavedTrips
          }
        }
      GQL
    end
  end
end
