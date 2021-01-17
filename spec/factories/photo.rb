FactoryBot.define do
  factory :photo do
    url { Faker::Avatar.image }
    artist_name { Faker::Artist.name }
    artist_profile { Faker::Internet.url }
    user_uploaded { [true, false].sample }
    unsplash_id { Faker::Internet.password }
    user_photo_url { Faker::Avatar.image }
  end
end
