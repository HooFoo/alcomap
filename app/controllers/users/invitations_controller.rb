class Users::InvitationsController < Devise::InvitationsController


  def update
    puts params.inspect
    super
  end

  before_filter :configure_permitted_parameters


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation) << [:name, :email, :invitation_relation]
  end
end