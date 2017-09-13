class AddPhotoIdToDownloadGalleryPhoto < ActiveRecord::Migration
  def change
    add_column :download_gallery_photos, :photo_ids, :integer, array: true, default: []
  end
end
