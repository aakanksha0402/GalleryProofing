class AddImageToAlbumPhotos < ActiveRecord::Migration
  def change
    add_column :album_photos, :albumphoto, :string
  end
end
