class PointExtention < ActiveRecord::Migration
  def up
    add_column :points, :isFulltime, :boolean, :default => true
    add_column :points, :cardAccepted, :boolean, :default => false
    add_column :points, :beer, :boolean, :default => true
    add_column :points, :hard, :boolean, :default => true
    add_column :points, :elite, :boolean, :default => false
    Point.where("name = 'Росал'").update_all(:elite => true, :cardAccepted => true)
  end
  def down
    remove_column :points, :isFulltime, :boolean
    remove_column :points, :cardAccepted, :boolean
    remove_column :points, :beer, :boolean
    remove_column :points, :hard, :boolean
    remove_column :points, :elite, :boolean
  end
end
