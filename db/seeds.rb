
user_one = User.create(name: 'User 1', email: 'user1@mail.com', password: 'password')
user_two = User.create(name: 'User 2', email: 'user2@mail.com', password: 'password')
User.create(name: 'Admin', email: 'admin@mail.com', password: 'password', role: 1)

location_one = Location.create(country: 'USA', state: 'Colorado')
location_two = Location.create(country: 'USA', state: 'California')
location_three = Location.create(country: 'USA', state: 'Michigan')
location_four = Location.create(country: 'USA', state: 'Washington')

# User one posts
(1..6).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_one, location: location_one)
end

Post.create(title: 'Post 7', body: 'Body text', user: user_one, location: location_two)

(8..11).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_one, location: location_three)
end

(12..16).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_one, location: location_four)
end

# User two posts
Post.create(title: 'Post 17', body: 'Body text', user: user_two, location: location_one)

(18..22).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_two, location: location_two)
end

(23..25).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_two, location: location_three)
end

(26..36).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_two, location: location_four)
end
