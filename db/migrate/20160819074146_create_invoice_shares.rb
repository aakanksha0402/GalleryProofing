class CreateInvoiceShares < ActiveRecord::Migration
  def change
    create_table :invoice_shares do |t|
      t.string :recipient
      t.string :subject
      t.string :headline
      t.string :buttontext
      t.string :message
      t.references :email_template, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
