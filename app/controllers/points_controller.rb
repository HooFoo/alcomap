class PointsController < InheritedResources::Base

  respond_to :json

  def create
    @point = build_resource
    @point.user = current_user
    @point.save
    News.new(:user => current_user, :point => @point).save
    render 'show'
  end

  def index(options={}, &block)
    bounds = params[:bounds]
    if bounds.nil?
      super
    else
      parsed = JSON.parse bounds
      @points = Point.mixed.visible parsed
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
    rated_list = RatedPoint.where('user_id = :uid and point_id = :pid', {uid: user.id, pid: @point.id})
    if rated_list.length==0
      rated = RatedPoint.new :direction => params[:direction],
                             :user => user,
                             :point => @point
      if params[:direction]
        rating = 1
      else
        rating = -1
      end
      @point.rating+=rating
      @point.save
      rated.save
      if @point.rating <= -5
        @point.destroy
      end
    end
    render 'show.json'
  end

  private

  def point_params
    params.require(:point).permit(:lng, :lat, :name, :description, :point_type, :user_id, :isFulltime, :cardAccepted, :beer, :hard, :elite)
  end
end

