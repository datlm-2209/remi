FactoryBot.define do
  factory :user do
    sequence(:username){|n| "TestUser#{n}"}
    sequence(:email){|n| "test+#{n}@test.com"}
    password{"Aa@123456"}
  end
end
