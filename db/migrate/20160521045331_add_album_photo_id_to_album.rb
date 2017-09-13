class AddAlbumPhotoIdToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :album_photo_id, :integer,default: 0
  end
end
