class CreateReferFriends < ActiveRecord::Migration
  def change
    create_table :refer_friends do |t|
      t.string :email_address
      t.string :email_body
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
