class CreateAlbumShares < ActiveRecord::Migration
  def change
    create_table :album_shares do |t|
      t.string :recipient
      t.string :subject
      t.string :headline
      t.string :buttontext
      t.string :message
      t.integer :album_id

      t.timestamps null: false
    end
  end
end
