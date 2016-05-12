class CreateAddProfilesAndSettingsToUsers < ActiveRecord::Migration
  def up
    User.all.each do |user|
      if user.setting.nil?
        user.setting = Setting.new(:json => '{"shops":true,"bars":true,"markers":true,"messages":true,"users":true}',
                                     :user_id => user.id)
      end
      if user.profile.nil?
        user.profile = Profile.new(:age => 18,
                                     :sex => 'male',
                                     :comment => '',
                                     :user_id => user.id)
      end
      user.save!
    end
  end

  def down

  end
end
