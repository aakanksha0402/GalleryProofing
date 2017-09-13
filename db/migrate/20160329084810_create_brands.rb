class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.references :user, index: true, foreign_key: true
      t.string :brand_name
      t.string :website_url
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :primary_country
      t.integer :brand_country
      t.string :pincode
      t.string :phone_number
      t.boolean :default

      t.timestamps null: false
    end
  end
end
