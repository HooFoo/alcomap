class AddAttachmentPictureToPoints < ActiveRecord::Migration
  def self.up
    change_table :points do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :points, :picture
  end
end
