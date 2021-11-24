FactoryBot.define do
  factory :target do
    title { Faker::Science.science }
    radius { Faker::Number.between(from: 1, to: 1000) }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
    topic
  end
end
