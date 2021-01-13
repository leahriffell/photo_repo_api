FactoryBot.define do
  factory :photo do
    description { Faker::Hipster.sentence }
    url { Faker::Avatar.image }
    artist {{ name: Faker::Artist.name, profile: Faker::Internet.url }} 
  end
end
