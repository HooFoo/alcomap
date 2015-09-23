class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  has_many :media
  validates :text, presence: true
  validates :user, presence: true
  validates :point, presence: true

  before_save :spam_stop

  protected

  def spam_stop
    comment = Comment.where(user_id: self.user_id).last
    (Time.current - comment.created_at > 5) &&
        (self.text != comment.text) unless comment.nil?
  end
end