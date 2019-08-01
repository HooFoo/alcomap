class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "vk") if is_navigational_format?
    else
      @user.save
      sign_in(@user)
      redirect_to root_path
      set_flash_message(:notice, :success, :kind => "vk") if is_navigational_format?
    end
  end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "facebook") if is_navigational_format?
    else
      @user.save
      sign_in(@user)
      redirect_to root_path
      set_flash_message(:notice, :success, :kind => "facebook") if is_navigational_format?
    end
  end

  def failure
    redirect_to root_path
  end
end