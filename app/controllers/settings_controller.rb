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
    if @setting.nil?
      @setting = Setting.new(id: current_user.id)
    end
    if params[:json] != '{}'
      @setting.json = params[:json]
      @setting.save!
    end
    render :json => {:result => :ok}
  end

  def index
    @setting = current_user.setting
    if @setting.nil?
      @setting = {json: {shops: true,
                         bars: true,
                         messages: true,
                         markers: true,
                         users: true},
                  id: 0,
                  user_id: 0,
                  created_at: Time.now,
                  updated_at: Time.now}
    end

    render 'show'
  end

  private

  def setting_params
    params.require(:setting).permit(:json, :user_id)
  end

end

