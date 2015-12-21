class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  has_many :media
  validates :text, presence: true
  validates :user, presence: true
  validates :point, presence: true

  before_save :spam_stop

  #has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  #validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  protected

  def spam_stop
    comment = Comment.where(user_id: self.user_id).last
    (Time.current - comment.created_at > 5) &&
        (self.text != comment.text) unless comment.nil?
  end
end