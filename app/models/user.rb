class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :points
  has_many :comments
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  has_many :rated_points
  has_many :chat_messages
  has_one :setting
  has_many :media

  def self.online
    where('updated_at > ?', 20.seconds.ago)
  end

  def self.online_count
    where({:updated_at => 20.seconds.ago..Time.now}).count
  end

  def online?
    updated_at < 20.seconds
  end
end
