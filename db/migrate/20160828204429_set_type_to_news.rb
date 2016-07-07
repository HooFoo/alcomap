class SetTypeToNews < ActiveRecord::Migration
  def change
    News.all.each do |n|
      if n.point.nil?
        n.destroy
      else
        n.point_type = n.point.point_type
        n.save!
      end
    end
  end
end
