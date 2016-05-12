class CreateSettings < ActiveRecord::Migration
  def change
    if ! ActiveRecord::Base.connection.table_exists? 'settings'
      create_table :settings do |t|
      t.string :json
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
      end
    end
  end
end
