FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 5..10) }
    email { Faker::Internet.email }
    password { "Aa@123456" }
  end
end
