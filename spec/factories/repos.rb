FactoryGirl.define do
  factory :repo do
    organization { Faker::Commerce.department }
    name { Faker::App.name }
    description { Faker::Company.catch_phrase }
    url { Faker::Internet.url }
    owner factory: :user
    before(:create) do |repo, _evaluator|
      repo.company = repo.owner.company
    end
  end
end
