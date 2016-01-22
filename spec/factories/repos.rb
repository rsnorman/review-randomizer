FactoryGirl.define do
  factory :repo do
    company { Faker::Company.name }
    organization { Faker::Commerce.department }
    name { Faker::App.name }
    description { Faker::Company.catch_phrase }
    url { Faker::Internet.url }
    owner factory: :user
  end
end
