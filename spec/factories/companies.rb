FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    domain { Faker::Internet.domain_name }
    owner factory: :admin
  end
end
