class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  respond_to :json, :html
  layout :layout_by_resource
  after_filter :user_activity

  protected

  def layout_by_resource
    if devise_controller?
      'users'
    else
      'application'
    end
  end


  private

  def user_activity
    current_user.try :touch
  end

end
