class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :gallery, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
