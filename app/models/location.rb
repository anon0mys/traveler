class Location < ApplicationRecord
  has_many :posts
  has_many :users, through: :posts

  def self.sum_of_countries
    select('locations.*')
      .joins(:posts)
      .group(:country)
      .order('count_location_id DESC')
      .count(:location_id)
      .to_a
  end

  def self.maps_loc_prep
    all.as_json(only: [:lat, :lng])
  end
end
