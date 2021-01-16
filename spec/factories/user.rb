FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password_digest { Faker::Internet.password }

    trait :with_trips do
      after(:create) do |user|
        create_list(:trip, 3, user: user)
      end
    end
  end
end
