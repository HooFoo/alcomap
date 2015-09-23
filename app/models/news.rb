class News < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  validates :user, presence: true
  validates :point, presence: true

end
