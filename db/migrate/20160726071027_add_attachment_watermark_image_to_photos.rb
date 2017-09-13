class AddAttachmentWatermarkImageToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :watermark_image
    end
  end

  def self.down
    remove_attachment :photos, :watermark_image
  end
end
