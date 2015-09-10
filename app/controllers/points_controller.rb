class PointsController < InheritedResources::Base

  respond_to :json

  def create(options={}, &block)
    @point = build_resource

    @point.user = current_user

    if create_resource(@point)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(@point, options, &block)
  end

  def index(options={}, &block)
    bounds = params[:bounds]
    unless bounds.nil?
      parsed = JSON.parse bounds
      @points = Point.where("lat <= #{parsed['Da']['j']} and lat >= #{parsed['Da']['A']} and lng <= #{parsed['va']['A']} and lng >= #{parsed['va']['j']}")
    else
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
        render json: nil
      end
    end
    render 'show.json'
  end

  private

  def point_params
    params.require(:point).permit(:lng, :lat, :name, :description, :user_id)
  end
end

