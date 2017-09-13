class CreateMobileappPhotos < ActiveRecord::Migration
  def change
    create_table :mobileapp_photos do |t|

      t.timestamps null: false
    end
  end
end
