class CreateAlbumPhotos < ActiveRecord::Migration
  def change
    create_table :album_photos do |t|
      t.references :album, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
