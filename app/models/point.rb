class Point < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :delete_all
  has_many :rated_points, :dependent => :delete_all
  validates :user, presence: true
  validates :lng, :lat, :name, presence: true
  validates :lng, :lat, numericality: true
end
