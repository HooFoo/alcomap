class Users::RegistrationsController < Devise::RegistrationsController


  before_filter :configure_permitted_parameters

  def after_update_path_for resource
    '/users/edit'
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :invitation_token)
    devise_parameter_sanitizer.for(:account_update)
        .push(:name, :email, :password, :password_confirmation,:current_password)
  end
end