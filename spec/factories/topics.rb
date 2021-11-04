FactoryBot.define do
  factory :topic do
    name { Faker::Science.science }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'files', 'image.png')) }
  end
end
