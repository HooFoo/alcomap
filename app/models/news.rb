class News < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
end
