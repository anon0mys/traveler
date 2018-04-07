require 'csv'
data = CSV.open('./db/all_countries.csv', headers: true, header_converters: :symbol)
data.map do |row|
  Country.create(name: row[:name], code: row[:country], lat: row[:latitude], lng: row[:longitude])
end

user_one = User.create(name: 'User 1', email: 'user1@mail.com', password: 'password')
user_two = User.create(name: 'User 2', email: 'user2@mail.com', password: 'password')
User.create(name: 'Admin', email: 'admin@mail.com', password: 'password', role: 1)

location_one = Location.create(country: Country.find_by(code: 'US'), lat: 39.742043, lng: -104.991531)
location_two = Location.create(country: Country.find_by(code: 'US'), lat: 37.09024, lng: -95.712891)
location_three = Location.create(country: Country.find_by(code: 'US'), lat: 39.742043, lng: -104.991531)
location_four = Location.create(country: Country.find_by(code: 'US'), lat: 41.87194, lng: 12.56738)
location_five = Location.create(country: Country.find_by(code: 'US'), lat: 46.227638, lng: 2.213749)
location_six = Location.create(country: Country.find_by(code: 'US'), lat: 55.378051, lng: -3.435973)
location_seven = Location.create(country: Country.find_by(code: 'US'), lat: -30.559482, lng: 22.937506)

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

(37..45).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_two, location: location_five)
end

(46..49).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_two, location: location_six)
end

(50..58).each do |num|
  Post.create(title: "Post #{num}", body: 'Body text', user: user_two, location: location_seven)
end
