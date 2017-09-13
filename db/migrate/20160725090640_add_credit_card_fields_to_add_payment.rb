class AddCreditCardFieldsToAddPayment < ActiveRecord::Migration
  def change
    add_column :add_payments, :authorization, :string
    add_column :add_payments, :message, :string
    add_column :add_payments, :success, :string
  end
end
