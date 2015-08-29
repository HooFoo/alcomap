class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :long
      t.float :lat
      t.string :name
      t.string :description
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
