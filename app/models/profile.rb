class Profile < ActiveRecord::Base
  belongs_to :user

  enum sexes: [:male, :female]

  validates_inclusion_of :sex, in: Profile.sexes.keys
  validates_inclusion_of :age, in: 18..99


end
