class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :email_id
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :country
      t.integer :pin
      t.integer :phone_no
      t.text :notes_to_studio
      t.references :gallery, index: true, foreign_key: true
      t.text :studio_internal_notes
      t.string :status

      t.timestamps null: false
    end
  end
end
