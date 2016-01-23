FactoryGirl.define do
  factory :team do
    name  { Faker::Team.name }
    leader factory: :user
  end
end
