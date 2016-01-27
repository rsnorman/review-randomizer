FactoryGirl.define do
  factory :team do
    name  { Faker::Team.name }
    leader factory: :user
    before(:create) do |team, _evaluator|
      team.company = team.leader.company
    end
  end
end
