class Point < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :delete_all
  has_many :rated_points, :dependent => :delete_all
  has_many :news, :dependent => :delete_all
  has_many :media
  validates :user, presence: true
  validates :lng, :lat, :name, presence: true
  validates :lng, :lat, numericality: true
  # validates_attachment_presence :picture, presence: false,
  #                               content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
  #                               less_than: 1.megabytes


  #has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  #validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  def self.shops(coords)
    where("lat <= #{coords['ne']['lat']} and lat >= #{coords['sw']['lat']} and lng <= #{coords['ne']['lng']} and lng >= #{coords['sw']['lng']} and point_type = 'shop'")
  end

  def self.bars(coords)
    where("lat <= #{coords['ne']['lat']} and lat >= #{coords['sw']['lat']} and lng <= #{coords['ne']['lng']} and lng >= #{coords['sw']['lng']} and point_type = 'bar'")
  end

  def self.markers(coords)
    where("lat <= #{coords['ne']['lat']} and lat >= #{coords['sw']['lat']} and lng <= #{coords['ne']['lng']} and lng >= #{coords['sw']['lng']} and point_type = 'marker' AND created_at >= ?", Date.today - 7)
  end

  def self.messages(coords)
    where("lat <= #{coords['ne']['lat']} and lat >= #{coords['sw']['lat']} and lng <= #{coords['ne']['lng']} and lng >= #{coords['sw']['lng']} and point_type = 'message' AND created_at >= ?", DateTime.now-30.minutes)
  end

  def self.visible(coords)
    where("lat <= #{coords['ne']['lat']} and lat >= #{coords['sw']['lat']} and lng <= #{coords['ne']['lng']} and lng >= #{coords['sw']['lng']}")
  end

  def self.mixed(coords)
    where("lat <= #{coords['ne']['lat']} and lat >= #{coords['sw']['lat']} and lng <= #{coords['ne']['lng']} and lng >= #{coords['sw']['lng']} and (point_type = 'shop') or (point_type = 'bar') or (point_type = 'message' AND created_at >= ?) or (point_type = 'marker' AND created_at >= ?)", DateTime.now-30.minutes, Date.today - 7)
  end
end
