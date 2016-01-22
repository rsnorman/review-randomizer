FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    handle { Faker::Internet.user_name }
    role 'User'
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end

  factory :admin, class: User do
    name 'Administrator'
    handle 'admin'
    role 'Admin'
    email 'admin@review-randomizer.com'
    password 'supersecret'
  end
end
