class SettingsController < InheritedResources::Base
  belongs_to :user
  respond_to :json
  actions :all, :except => [:destroy, :create]

  def create
    @setting = Setting.new :json => params[:json],
                           :user => current_user
    @setting.save
  end
  def update
    @setting = Setting.find_by_user_id current_user.id
    @setting.json = params[:json]
    @setting.save!
    render :json => {:result => :ok}
  end

  def index
    @setting = current_user.setting
    render 'show'
  end

  private

  def setting_params
    params.require(:setting).permit(:json, :user_id)
  end
end

