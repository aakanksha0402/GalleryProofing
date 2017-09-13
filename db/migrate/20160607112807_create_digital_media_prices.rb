class CreateDigitalMediaPrices < ActiveRecord::Migration
  def change
    create_table :digital_media_prices do |t|
      t.decimal :indiviual_photo_price,default: 0.0
      t.boolean :individual_price_active,default: false
      t.decimal :all_album_photo_price,default: 0.0
      t.boolean :all_album_price_active,default: false
      t.decimal :all_gallery_photo_price,default: 0.0
      t.boolean :all_gallery_price_active,default: false
      t.references :catalog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
