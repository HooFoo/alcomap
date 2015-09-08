class UsersController < InheritedResources::Base

  respond_to :json

  private

    def user_params
      params.require(:user).permit(:name)
    end
end

