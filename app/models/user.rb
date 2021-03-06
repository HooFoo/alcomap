class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:vkontakte, :facebook]


  has_many :points
  has_many :comments
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  has_many :rated_points
  has_many :chat_messages
  has_one :setting
  has_many :media
  has_one :profile
  validates :email, :uniqueness => true

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

  def self.from_omniauth(auth)
    Rails.logger.info(auth.inspect)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{SecureRandom.hex(8)}@example.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.first_name + ' ' + auth.info.last_name   # assuming the user model has a name
    end
  end

  def online?
    updated_at >= 20.seconds.ago
  end
end
