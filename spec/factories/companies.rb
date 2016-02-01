FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    domain { Faker::Internet.domain_name }
    owner factory: :admin
    initialize_with do
      Company.first || new(name: name, domain: domain, owner: owner)
    end

    trait :multiple do
      initialize_with { new(name: name, domain: domain, owner: owner) }
    end
  end
end
