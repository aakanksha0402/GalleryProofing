class RemoveFieldsFromAlbumPhotos < ActiveRecord::Migration
  def change
    remove_column :album_photos, :albumphotos
    remove_column :album_photos, :albumphoto
  end
end
