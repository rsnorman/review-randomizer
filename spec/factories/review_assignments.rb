FactoryGirl.define do
  factory :review_assignment do
    pull_request
    team_membership

    trait :with_user do
      team_membership factory: [:team_membership, :with_user]
    end
  end
end
