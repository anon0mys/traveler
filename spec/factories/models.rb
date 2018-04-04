FactoryBot.define do
  factory :location do
    state 'Colorado'
    sequence(:country, 1) { |n| "Country #{n}" }
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
