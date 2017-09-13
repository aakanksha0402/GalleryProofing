class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.references :gallery
      t.string :gallery_access_code
      t.boolean :favorite_photo_privilege, default: true
      t.boolean :hide_photo_privilege, default: false
      t.boolean :label_photo_privilege, default: false

      t.timestamps null: false
    end
  end
end
