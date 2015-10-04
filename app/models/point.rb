class Point < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :delete_all
  has_many :rated_points, :dependent => :delete_all
  has_many :news, :dependent => :delete_all
  has_many :media
  validates :user, presence: true
  validates :lng, :lat, :name, presence: true
  validates :lng, :lat, numericality: true

  def self.shops(coords)
    where("lat <= #{coords['Da']['j']} and lat >= #{coords['Da']['A']} and lng <= #{coords['va']['A']} and lng >= #{coords['va']['j']} and point_type = 'shop'")
  end

  def self.bars(coords)
    where("lat <= #{coords['Da']['j']} and lat >= #{coords['Da']['A']} and lng <= #{coords['va']['A']} and lng >= #{coords['va']['j']} and point_type = 'bar'")
  end

  def self.markers(coords)
    where("lat <= #{coords['Da']['j']} and lat >= #{coords['Da']['A']} and lng <= #{coords['va']['A']} and lng >= #{coords['va']['j']} and point_type = 'marker' AND created_at >= ?", Date.today - 7)
  end

  def self.messages(coords)
    where("lat <= #{coords['Da']['j']} and lat >= #{coords['Da']['A']} and lng <= #{coords['va']['A']} and lng >= #{coords['va']['j']} and point_type = 'message' AND created_at >= ?", DateTime.now-30.minutes)
  end

  def self.visible(coords)
    where("lat <= #{coords['Da']['j']} and lat >= #{coords['Da']['A']} and lng <= #{coords['va']['A']} and lng >= #{coords['va']['j']}")
  end

  def self.mixed(coords)
    where("lat <= #{coords['Da']['j']} and lat >= #{coords['Da']['A']} and lng <= #{coords['va']['A']} and lng >= #{coords['va']['j']} and (point_type = 'shop') or (point_type = 'bar') or (point_type = 'message' AND created_at >= ?) or (point_type = 'marker' AND created_at >= ?)", DateTime.now-30.minutes, Date.today - 7)
  end
end
