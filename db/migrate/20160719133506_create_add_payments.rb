class CreateAddPayments < ActiveRecord::Migration
  def change
    create_table :add_payments do |t|
      t.references :invoice, index: true, foreign_key: true
      t.references :payment_with, index: true, foreign_key: true
      t.date :payment_date
      t.decimal :amount
      t.integer :cheque_no
      t.text :cash_cheque_memo
      t.text :credit_card_memo

      t.timestamps null: false
    end
  end
end
