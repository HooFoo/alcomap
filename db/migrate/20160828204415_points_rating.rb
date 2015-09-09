class PointsRating < ActiveRecord::Migration
  def change
    add_column :points, :rating, :string, default: 0
  end
end
