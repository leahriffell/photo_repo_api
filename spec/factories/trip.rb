FactoryBot.define do
  factory :trip do
    destination { Faker::Nation.capital_city }
    traveled_to { [true, false].sample }
    association :user
  end
end
