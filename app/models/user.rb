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
  has_one :profile

  after_create do |user|
    user.setting ||= Setting.new(:json => '{"shops":true,"bars":true,"messages":true,"markers":true,"users":true}',
                                 :user_id => user.id)
    user.profile ||= Profile.new(:age => 18,
                                 :sex => 'male',
                                 :comment => '',
                                 :user_id => user.id)
  end

  def self.online
    where('updated_at > ?', 20.seconds.ago)
  end

  def self.online_count
    where({:updated_at => 20.seconds.ago..Time.now}).count
  end

  def online?
    updated_at >= 20.seconds.ago
  end
end
