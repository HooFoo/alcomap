class Users::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) << [:name,:email]
  end
end