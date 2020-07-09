FactoryBot.define do
  factory :user do
    name { "test_user_name" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end