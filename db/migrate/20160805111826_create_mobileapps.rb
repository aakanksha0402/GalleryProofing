class CreateMobileapps < ActiveRecord::Migration
  def change
    create_table :mobileapps do |t|
      t.string :name
      t.boolean :contact_info
      t.boolean :social_sharing
      t.boolean :layout
      t.string :language
      t.references :mobileapp_photo, index: true, foreign_key: true
      t.references :color_logo, index: true, foreign_key: true
      t.references :mobileapp_custom_link, index: true, foreign_key: true
      t.references :gallery, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
