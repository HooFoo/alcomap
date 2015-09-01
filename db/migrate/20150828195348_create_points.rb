class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :lng
      t.float :lat
      t.string :name
      t.string :description


      t.timestamps null: false
    end
  end
end
