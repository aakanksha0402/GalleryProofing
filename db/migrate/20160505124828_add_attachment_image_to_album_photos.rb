class AddAttachmentImageToAlbumPhotos < ActiveRecord::Migration
  def self.up
    change_table :album_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :album_photos, :image
  end
end
