class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :brand, index: true, foreign_key: true
      t.references :client_contact, index: true, foreign_key: true
      t.references :automation_series, index: true, foreign_key: true
      t.references :color_logo, index: true, foreign_key: true
      t.date :issue_date
      t.date :final_due_date
      t.string :sales_label
      t.decimal :sales_rate
      t.text :notes_to_client
      t.references :discount_type, index: true, foreign_key: true
      t.decimal :deposit_amount
      t.boolean :allow_payment_cash_cheque
      t.boolean :allow_payment_credit_card
      t.text :payment_confirmation_text

      t.timestamps null: false
    end
  end
end
