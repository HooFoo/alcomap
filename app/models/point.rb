class Point < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :user, presence: true
  validates :lng,:lat,:name, presence: true
  validates :lng,:lat, numericality: true
end
