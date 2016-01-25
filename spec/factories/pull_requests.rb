FactoryGirl.define do
  factory :pull_request do
    repo
    title { Faker::Hacker.say_something_smart }
    sequence(:number) { |n| n }
  end
end
