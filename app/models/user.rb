class User < ApplicationRecord
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  has_many :posts
  has_many :comments
  has_many :locations, through: :posts
  has_secure_password

  enum role: %i[default admin]

  def top_three_locations
    locations.joins(:countries)
             .group(:country_id)
             .order('count_country DESC')
             .count(:country_id)
             .first(3)
             .to_h
  end
end
