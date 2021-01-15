require 'rails_helper'

RSpec.describe 'Photo Details PORO' do
  it 'exists' do 
    attributes = {
      :id=>"rknrvCrfS1k",
      :created_at=>"2018-01-20T16:28:57-05:00",
      :updated_at=>"2021-01-09T04:02:54-05:00",
      :promoted_at=>"2018-01-21T07:32:39-05:00",
      :width=>2675,
      :height=>4027,
      :color=>"#c0d9f3",
      :blur_hash=>"L,H2i[M_oge._4Rjofa}XnbcWAW=",
      :description=>"The Cliffs of Cinque Terre",
      :alt_description=>"Manarola, Italy",
      :urls=>
      {:raw=>"https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1",
        :full=>
        "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1&q=85",
        :regular=>
        "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=1080",
        :small=>
        "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=400",
        :thumb=>
        "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxODEwNDd8MHwxfHNlYXJjaHwxfHxJdGFseXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=200"},
      :links=>
      {:self=>"https://api.unsplash.com/photos/rknrvCrfS1k",
        :html=>"https://unsplash.com/photos/rknrvCrfS1k",
        :download=>"https://unsplash.com/photos/rknrvCrfS1k/download",
        :download_location=>"https://api.unsplash.com/photos/rknrvCrfS1k/download"},
      :categories=>[],
      :likes=>1522,
      :liked_by_user=>false,
      :current_user_collections=>[],
      :sponsorship=>nil,
      :user=>
      {:id=>"NuPaOVVjvqA",
        :updated_at=>"2021-01-09T13:26:23-05:00",
        :username=>"jackward",
        :name=>"Jack Ward",
        :first_name=>"Jack",
        :last_name=>"Ward",
        :twitter_username=>"jwardu",
        :portfolio_url=>nil,
        :bio=>"Adventure/Landscape Photographer",
        :location=>"Boston, Ma",
        :links=>
        {:self=>"https://api.unsplash.com/users/jackward",
          :html=>"https://unsplash.com/@jackward",
          :photos=>"https://api.unsplash.com/users/jackward/photos",
          :likes=>"https://api.unsplash.com/users/jackward/likes",
          :portfolio=>"https://api.unsplash.com/users/jackward/portfolio",
          :following=>"https://api.unsplash.com/users/jackward/following",
          :followers=>"https://api.unsplash.com/users/jackward/followers"},
        :profile_image=>
        {:small=>"https://images.unsplash.com/profile-1522420435626-e26c29024ea9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32",
          :medium=>"https://images.unsplash.com/profile-1522420435626-e26c29024ea9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64",
          :large=>"https://images.unsplash.com/profile-1522420435626-e26c29024ea9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"},
        :instagram_username=>"jwardu",
        :total_collections=>0,
        :total_likes=>889,
        :total_photos=>208,
        :accepted_tos=>true},
      :tags=>[]
    }

    symbolized_attr = attributes.deep_symbolize_keys
    
    photo = PhotoDetails.new(symbolized_attr)

    expect(photo).to be_a(PhotoDetails)

    expect(photo.description).to eq(symbolized_attr[:description])
    expect(photo.url).to eq(symbolized_attr[:urls][:regular])
    expect(photo.artist_name).to eq(symbolized_attr[:user][:name])
    expect(photo.artist_profile).to eq(symbolized_attr[:user][:links][:html])
    expect(photo.unsplash_id).to eq(symbolized_attr[:id])
  end
end