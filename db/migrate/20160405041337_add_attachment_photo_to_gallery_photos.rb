class AddAttachmentPhotoToGalleryPhotos < ActiveRecord::Migration
  def self.up
    change_table :gallery_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :gallery_photos, :photo
  end
end
