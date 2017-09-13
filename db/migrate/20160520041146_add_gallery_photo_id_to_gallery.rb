class AddGalleryPhotoIdToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :gallery_photo_id, :integer,default: 0
  end
end
