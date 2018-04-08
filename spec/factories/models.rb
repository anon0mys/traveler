FactoryBot.define do
  factory :country do
    code "US"
    lat { rand(-90..90) }
    lng { rand(-180..180) }
    sequence(:name, 1) { |n| "Country #{n}" }
  end

  factory :location do
    association :country
    lat { rand(-90..90) }
    lng { rand(-180..180) }
  end

  factory :post do
    sequence(:title, 1) { |n| "Post #{n}" }
    body 'Test body for all posts'
    association :location
    association :user
  end

  factory :user do
    name 'User'
    sequence(:email, 1) { |n| "person#{n}@email.com" }
    password 'password'
  end
end
