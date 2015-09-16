class AddPointType < ActiveRecord::Migration
  def up
    add_column :points, :point_type, :string
    Point.all.map do |element|
      element.point_type = 'shop'
      element.save
    end
  end

  def down
    remove_column :points, :point_type, :string
  end
end
