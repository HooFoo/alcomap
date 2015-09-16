json.extract! @user, :id, :name, :created_at, :updated_at
unless @user.setting.nil?
  json.settings = @user.setting
end
