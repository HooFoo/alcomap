class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
end
