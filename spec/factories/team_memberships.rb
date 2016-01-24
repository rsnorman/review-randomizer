FactoryGirl.define do
  factory :team_membership do
    handle { Faker::Internet.user_name }

    trait :with_user do
      user
    end
  end
end
