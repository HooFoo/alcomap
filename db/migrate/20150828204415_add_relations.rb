class AddRelations < ActiveRecord::Migration
  def change
    change_table :points do |t|
      t.belongs_to :user, index: true, foreign_key: true
    end
    change_table :comments do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :point, index: true, foreign_key: true
    end
  end
end
