class AddPointTypeToNews < ActiveRecord::Migration
  def change
    change_table :news do |t|
      t.string :point_type # for settings
    end
  end
end
