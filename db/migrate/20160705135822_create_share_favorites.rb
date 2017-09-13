class CreateShareFavorites < ActiveRecord::Migration
  def change
    create_table :share_favorites do |t|
      t.references :gallery_visitor, index: true, foreign_key: true
      t.string :name
      t.string :to_email
      t.string :message
      t.string :token

      t.timestamps null: false
    end
  end
end
