require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'fetch all users' do
    it 'can query all users' do
      create_list(:user, 2, :with_photo_trip)

      post graphql_path, params: { query: query }
      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:getUsers]

      expect(data.size).to eq(2)

      users = User.all

      expect(data).to match_array(
        users.map do |user|
          { 
            id: user.id.to_s, 
            email: user.email,
            photos: user.photos.map do |photo|
              {
                id: photo.id.to_s,
                url: photo.url,
                artistName: photo.artist_name,
                artistProfile: photo.artist_profile,
                unsplashId: photo.unsplash_id,
                userUploaded: photo.user_uploaded 
              }
            end,
            trips: user.trips.map do |trip|
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
          }
        end
      )
    end
  end

  def query
    <<~GQL
      {
        getUsers {
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
