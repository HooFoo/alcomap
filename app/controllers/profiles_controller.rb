class ProfilesController < InheritedResources::Base

  belongs_to :user
  respond_to :json
  actions :all, :except => [:destroy, :create]

  def by_user
    @profile = Profile.find_by_user_id params[:user_id]
    render 'show'
  end

  def update
    authentificated? do
      @profile = current_user.profile
      @profile.sex = params[:profile][:sex]
      @profile.age = params[:profile][:age]
      @profile.comment = params[:profile][:comment]
      @profile.save!

      redirect_to '/users/edit', notice: 'Настройки сохранены'
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:age, :sex, :comment)
    end
end

