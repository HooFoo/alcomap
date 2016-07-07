class Users::InvitationsController < Devise::InvitationsController


  def after_invite_path_for resource
    '/users/invitation/new'
  end

  before_filter :configure_permitted_parameters

  def update
    super do |user|
      user.profile.age = params[:profile][:age]
      user.profile.sex = params[:profile][:sex]
      user.profile.comment = params[:profile][:comment]
      user.profile.save!
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :email, :invitation_relation])
  end

end