class RatedPoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :point, counter_cache: true
end
