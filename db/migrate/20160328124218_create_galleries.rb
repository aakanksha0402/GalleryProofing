class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.date :shoot_date
      t.date :release_date
      t.date :expiration_date
      t.string :custom_link
      t.string :cover_url
      t.boolean :archive

      t.timestamps null: false
    end
  end
end
