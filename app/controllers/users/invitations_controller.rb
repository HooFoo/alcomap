class Users::InvitationsController < Devise::InvitationsController

  helper_method :after_invite_path_for

  # POST /resource/invitation
  def after_invite_path_for resource
    '/users/invitation/new'
  end

  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) << [:name, :email, :invitation_relation]
  end

end