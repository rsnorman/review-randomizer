FactoryGirl.define do
  factory :user do
    name 'Ryan Norman'
    handle 'rsnorman'
    role 'User'
    email 'rsnorman@gmail.com'
    password 'test123'
  end

  factory :admin, class: User do
    name 'Administrator'
    handle 'admin'
    role 'Admin'
    email 'admin@review-randomizer.com'
    password 'supersecret'
  end
end
