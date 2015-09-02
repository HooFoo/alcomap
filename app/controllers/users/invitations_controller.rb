class Users::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
=begin
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:name,:email)
    end
=end
  end
end