class RemovePhotoIdsFromDownloadGalleryPhoto < ActiveRecord::Migration
  def change
    remove_column :download_gallery_photos, :photo_ids, :string
  end
end
