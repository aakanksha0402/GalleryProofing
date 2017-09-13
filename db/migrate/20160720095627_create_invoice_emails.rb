class CreateInvoiceEmails < ActiveRecord::Migration
  def change
    create_table :invoice_emails do |t|
      t.string :email_id
      t.references :email_template, index: true, foreign_key: true
      t.string :subject
      t.string :headline
      t.string :button_text
      t.text :message
      t.references :invoice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
