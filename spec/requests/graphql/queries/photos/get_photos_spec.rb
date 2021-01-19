require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'fetch all photos' do
    it 'can query all photos, including user uploaded and user saved from Unsplash' do
      # need to update this test to reflect files that are uploaded
      users = create_list(:user, 2, :with_trips)

      user_pic1 = create(:photo, url: nil, artist_name: nil, artist_profile: nil, unsplash_id: nil, user_uploaded: true)
      unsplash_pic1 = create(:photo, user_uploaded: false)
      users[0].trips.first.photos << [user_pic1, unsplash_pic1]

      user_pic2 = create(:photo, url: nil, artist_name: nil, artist_profile: nil, unsplash_id: nil, user_uploaded: true)
      unsplash_pic2 = create(:photo, user_uploaded: false)
      users[1].trips.first.photos << [user_pic2, unsplash_pic2]

      post graphql_path, params: { query: query }
      result = JSON.parse(response.body, symbolize_names: true)
      data = result[:data][:getPhotos]

      expect(data.size).to eq(4)

      expect(data).to match_array(
        Photo.all.map do |photo|
            { 
            id: photo.id.to_s, 
            url: photo.url,
            artistName: photo.artist_name,
            artistProfile: photo.artist_profile,
            unsplashId: photo.unsplash_id,
            userUploaded: photo.user_uploaded,
            userPhotoUrl: nil
            }
          end
        )
    end
  end

  def query
    <<~GQL
      {
        getPhotos {
          id
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
