class ChangeAlbumPhotoIdInAlbum < ActiveRecord::Migration
  def change
    change_column_default(:albums, :album_photo_id, nil)
  end
end
