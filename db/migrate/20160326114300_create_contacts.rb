class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :address
      t.string :city
      t.string :country
      t.integer :pincode
      t.integer :phone_number
      t.boolean :vendor
      t.string :buisinessname
      t.string :tags
      t.string :referredby

      t.timestamps null: false
    end
  end
end
