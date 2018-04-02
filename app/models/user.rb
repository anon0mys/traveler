class User < ApplicationRecord
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  has_many :posts
  has_many :comments
  has_many :locations, through: :posts
end
