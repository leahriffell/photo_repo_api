require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'fetch single user' do
    it 'can query single user by ID' do
      user = create(:user, :with_photo_trip)

      post graphql_path, params: { query: query(id: user.id) }
      result = JSON.parse(response.body, symbolize_names: true)

      data = result[:data][:getUser]

      expect(data[:id]).to eq(user.id.to_s)
      expect(data[:email]).to eq(user.email.to_s)
      
      expect(data[:photos]).to match_array(user.photos.map do |photo|
        {
          id: photo.id.to_s,
          url: photo.url,
          artistName: photo.artist_name,
          artistProfile: photo.artist_profile,
          unsplashId: photo.unsplash_id,
          userUploaded: photo.user_uploaded 
        }
      end
      )

      expect(data[:trips]).to match_array(user.trips.map do |trip|
        {
          id: trip.id.to_s,
          userId: user.id.to_s,
          destination: trip.destination,
          traveledTo: trip.traveled_to,
          latitude: trip.latitude,
          longitude: trip.longitude,
          photos: trip.photos.map do |photo|
            {
              id: photo.id.to_s,
              url: photo.url,
              artistName: photo.artist_name,
              artistProfile: photo.artist_profile,
              unsplashId: photo.unsplash_id,
              userUploaded: photo.user_uploaded 
            }
          end
        }
      end
      )
    end
  end

  def query(id:)
    <<~GQL
      {
        getUser(id: "#{id}") {
          id
          email
          photos {
            id
            url
            artistName
            artistProfile
            unsplashId
            userUploaded
          }
          trips {
            id
            userId
            destination
            traveledTo
            latitude
            longitude
            photos {
              id
              url
              artistName
              artistProfile
              unsplashId
              userUploaded
            }
          }
        }
      }
    GQL
  end
end
