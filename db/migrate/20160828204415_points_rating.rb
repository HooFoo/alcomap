class PointsRating < ActiveRecord::Migration
  def change
    add_column :points, :rating, :integer, default: 0
  end
end
