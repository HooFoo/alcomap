class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  validates :text, presence: true
  validates :user, presence: true
  validates :point, presence: true

  before_save :spam_stop

  protected

  def spam_stop
    comment = Comment.find_by_user_id(self.user_id).last
    (self.created_at-comment.created_at > 5000) &&
        (self.text != comment.text)
  end
end