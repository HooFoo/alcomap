class PointsController < InheritedResources::Base

  respond_to :json

  def create
    #process_picture
    @point = Point.new point_params
    @point.user = current_user
    if @point.save!
      News.new(:user => current_user, :point => @point).save
    end
    render 'show'
  end

  def index(options={}, &block)
    bounds = params[:bounds]
    if bounds.nil?
      super
    else
      get_points
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.user == current_user
      super
    end
  end

  def rate
    user = current_user
    @point = Point.find(params[:id])
    rate = RatedPoint.find_or_initialize_by point: @point, user: user
    rating = params[:direction] ? 1 : -1
    if rate.persisted?
      @point.rating = rate.direction ? @point.rating - 1 : @point.rating + 1
    end
    rate.direction = params[:direction]
    @point.rating+=rating
    @point.save
    rate.save
    if @point.rating <= -5
      @point.destroy
    end
    render 'show'
  end

  def get_points
    bounds = params[:bounds]
    settings = JSON.parse current_user.setting.json
    @points = Point.by_settings bounds,settings

    render 'index.json'
  end

  private

  def process_picture
    if params[:point] && params[:picture]
      puts params[:picture].inspect
      data = Т.new(Base64.decode64(params[:picture][:data]))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = params[:point][:picture][:filename]
      data.content_type = params[:point][:picture][:content_type]
      params[:point][:picture] = data
    end
  end
  
  def point_params
    params.require(:point).permit(:lng, :lat, :name, :description, :point_type, :isFulltime, :cardAccepted, :beer, :hard, :elite, :picture => [:data, :filename])
  end
end

