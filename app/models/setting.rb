class Setting < ActiveRecord::Base
  belongs_to :User

  def to_h
    JSON.parse json
  end
end
