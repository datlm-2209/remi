# spec/factories/videos.rb
FactoryBot.define do
  factory :video do
    title { Faker::Movie.title }
    description { Faker::Lorem.paragraph }
    url { Faker::Internet.url(host: 'example.com', path: '/video') }
    embed_url { Faker::Internet.url(host: 'example.com', path: '/embed/video') }
    association :user

    trait :with_invalid_url do
      url { "invalid_url" }
    end
  end
end
