class PointsController < InheritedResources::Base

  private

    def point_params
      params.require(:point).permit(:long,:lat, :name, :description, :user_id)
    end
end

