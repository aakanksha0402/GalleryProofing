class CreateTransactionSummaries < ActiveRecord::Migration
  def change
    create_table :transaction_summaries do |t|
      t.references :user, index: true, foreign_key: true
      t.string :description
      t.decimal :amount
      t.string :message
      t.boolean :success
      t.string :transaction_id
      t.string :customer_first_name
      t.string :customer_last_name
      t.string :processor_authorization_code
      t.string :processor_authentication_text
      t.string :last4
      t.string :card_token
      t.string :card_type
      t.string :unique_number_identifier

      t.timestamps null: false
    end
  end
end
