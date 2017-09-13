class CreateGalleryVisitors < ActiveRecord::Migration
  def change
    create_table :gallery_visitors do |t|
      t.string :email
      t.references :gallery, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
