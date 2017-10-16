class News < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  validates :user, presence: true
  validates :point, presence: true

  def self.by_settings settings
    types = settings.keys.map { |key| key.to_s.singularize if settings[key] }
    eager_load(:user,:point).where('points.point_type IN (?)',types).limit(20).reverse_order
  end
end
