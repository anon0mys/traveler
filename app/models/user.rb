class User < ApplicationRecord
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  has_many :posts
  has_many :comments
  has_many :locations, through: :posts
  has_secure_password

  enum role: %i[default admin]
  
  def top_three_locations
    locations.group(:country)
             .order('count_country DESC')
             .count(:country)
             .first(3)
             .to_h
  end
end
