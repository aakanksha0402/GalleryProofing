class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.string :email_id
      t.string :password
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :pincode
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
