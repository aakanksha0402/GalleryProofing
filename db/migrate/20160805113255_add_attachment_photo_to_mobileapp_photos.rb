class AddAttachmentPhotoToMobileappPhotos < ActiveRecord::Migration
  def self.up
    change_table :mobileapp_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :mobileapp_photos, :photo
  end
end
