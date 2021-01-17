FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password_digest { Faker::Internet.password }

    trait :with_trips do
      after(:create) do |user|
        create_list(:trip, 3, user: user)
      end
    end

    trait :with_photo_trip do
      after(:create) do |user|
        trips = create_list(:trip, 2, user: user)
        trips[0].photos << create(:photo, user_uploaded: true)
        trips[0].photos << create(:photo, user_uploaded: false)
        trips[1].photos << create(:photo, user_uploaded: true)
      end
    end
  end
end
