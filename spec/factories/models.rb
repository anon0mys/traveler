FactoryBot.define do
  factory :post do
    title 'Post'
    body 'Body of Article'
    location
  end

  factory :user do
    name 'User'
    email 'user@mail.com'
    password 'test'
  end

  factory :location do
    state 'Colorado'
    country 'USA'
  end
end
