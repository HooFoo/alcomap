class PointsController < InheritedResources::Base

  def create(options={}, &block)
    @point = build_resource

    @point.user = current_user

    if create_resource(@point)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(@point, options, &block)
  end

  def index(options={},&block)
    bounds = params[:bounds]
    unless(bounds.nil?)
      parsed = JSON.parse bounds
      @points = Point.where("lat <= #{parsed['Da']['j']} and lat >= #{parsed['Da']['A']} and lng <= #{parsed['va']['A']} and lng >= #{parsed['va']['j']}")
    else
      super
    end

  end

  private

  def point_params
    params.require(:point).permit(:lng, :lat, :name, :description, :user_id)
  end
end

