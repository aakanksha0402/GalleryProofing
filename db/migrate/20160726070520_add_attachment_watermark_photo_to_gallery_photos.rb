class AddAttachmentWatermarkPhotoToGalleryPhotos < ActiveRecord::Migration
  def self.up
    change_table :gallery_photos do |t|
      t.attachment :watermark_photo
    end
  end

  def self.down
    remove_attachment :gallery_photos, :watermark_photo
  end
end
