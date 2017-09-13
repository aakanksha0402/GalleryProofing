class CreateMobileappShares < ActiveRecord::Migration
  def change
    create_table :mobileapp_shares do |t|
      t.string :recipient
      t.string :subject
      t.string :headline
      t.string :buttontext
      t.text :message
      t.references :email_template, index: true, foreign_key: true
      t.references :mobileapp, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
