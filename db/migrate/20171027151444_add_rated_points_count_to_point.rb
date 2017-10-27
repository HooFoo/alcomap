class AddRatedPointsCountToPoint < ActiveRecord::Migration
  def change
    add_column :points, :rated_points_count, :integer
  end
end
