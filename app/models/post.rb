class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  accepts_nested_attributes_for :location
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON
end
