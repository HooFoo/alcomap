class PointsController < InheritedResources::Base

  def create(options={}, &block)
    @point = build_resource

    @point.user = current_user

    if create_resource(@point)
      options[:location] ||= smart_resource_url
    end

    respond_with_dual_blocks(@point, options, &block)
  end

  private

  def point_params
    params.require(:point).permit(:lng, :lat, :name, :description, :user_id)
  end
end

