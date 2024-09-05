# spec/factories/videos.rb
FactoryBot.define do
  factory :video do
    url { "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }
    association :user

    trait :with_invalid_url do
      url { "invalid_url" }
    end
  end
end
