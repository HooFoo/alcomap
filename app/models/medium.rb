class Medium < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  belongs_to :point
end
