class AddAttachmentPictureToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :comments, :picture
  end
end
