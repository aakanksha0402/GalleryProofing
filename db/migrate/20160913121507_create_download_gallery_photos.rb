class CreateDownloadGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :download_gallery_photos do |t|
      t.string :bundle
      t.string :photo_ids

      t.timestamps null: false
    end
  end
end
