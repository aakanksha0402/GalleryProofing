class AddAlbumPhotosToAlbumPhotos < ActiveRecord::Migration
  def change
    add_column :album_photos, :albumphotos,  :string, array: true, default: [] 
  end
end
