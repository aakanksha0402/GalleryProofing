class AddAttachmentAvatarToWatermarks < ActiveRecord::Migration
  def self.up
    change_table :watermarks do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :watermarks, :avatar
  end
end
