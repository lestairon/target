FactoryBot.define do
  factory :request do
    user
    text { Faker::Lorem.paragraph }
    status { 0 }
  end
end
