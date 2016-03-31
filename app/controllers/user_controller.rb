class UserController < ApplicationController

  respond_to :json

  def index
    @user = current_user || User.new(name: '')
  end

  def online_count
    Rails.logger.silence do
      render json: {:value => User.online_count}
    end
  end
end

