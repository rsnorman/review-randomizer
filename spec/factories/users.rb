FactoryGirl.define do
  factory :user do
    company
    name { Faker::Name.name }
    handle { Faker::Internet.user_name }
    role 'User'
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end

  factory :admin, class: User do
    name { "Administrator #{Faker::Name.name}" }
    handle { "admin_#{Faker::Internet.user_name}" }
    role 'Admin'
    sequence(:email) { |n| "admin+#{n}@review-randomizer.com" }
    password 'supersecret'
  end
end
