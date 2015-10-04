class UserController < ApplicationController

  respond_to :json

  def index
    @user = current_user
  end
  def online_count
    render json: {:value => User.online_count}
  end
end

