class CreateProfiles < ActiveRecord::Migration
  def change
    if ! ActiveRecord::Base.connection.table_exists? 'profiles'
      create_table :profiles do |t|
      t.integer :age
      t.string :sex
      t.string :comment
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
      end
    end
  end
end
