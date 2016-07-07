class Users::RegistrationsController < Devise::RegistrationsController


  before_filter :configure_permitted_parameters

  def after_update_path_for resource
    '/users/edit'
  end

  def edit
    @profile = current_user.profile
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :invitation_token])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation,:current_password])
  end
end