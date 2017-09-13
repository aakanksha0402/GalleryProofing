class CreateLabelPhotos < ActiveRecord::Migration
  def change
    create_table :label_photos do |t|
      t.references :label, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
