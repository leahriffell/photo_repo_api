FactoryBot.define do
  factory :trip do
    destination { Faker::Nation.capital_city }
    traveled_to { [true, false].sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    association :user
  end
end
