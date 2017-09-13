class ChangeGalleryPhotoIdInGallery < ActiveRecord::Migration
  def change
    change_column_default(:galleries, :gallery_photo_id, nil)
  end
end
