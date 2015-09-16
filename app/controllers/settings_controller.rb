class SettingsController < InheritedResources::Base
  belongs_to :user
  respond_to :json
  actions :all, :except => [:destroy]

  def create
    @setting = Setting.new :json => params[:json],
                           :user => current_user
    @setting.save
  end

  def index
    @setting = current_user.setting
    render 'show'
  end

  private

  def setting_params
    params.require(:setting).permit(:json, :User_id)
  end
end

