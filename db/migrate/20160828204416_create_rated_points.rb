class CreateRatedPoints < ActiveRecord::Migration
  def change
    create_table :rated_points do |t|
      t.boolean :direction
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :point, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
