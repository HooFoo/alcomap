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
end
