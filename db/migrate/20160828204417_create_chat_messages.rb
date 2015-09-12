class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.string :message
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
