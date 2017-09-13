class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :business_name
      t.string :note
      t.string :address1
      t.string :address2
      t.string :city
      t.references :state_province, index: true, foreign_key: true
      t.string :postal_code
      t.references :country, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
