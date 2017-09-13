class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.references :gallery, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
