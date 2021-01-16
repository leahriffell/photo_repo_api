FactoryBot.define do
  factory :trip do
    name { Faker::JapaneseMedia::StudioGhibli.character }
    traveled_to { [true, false].sample }
    association :user
  end
end
