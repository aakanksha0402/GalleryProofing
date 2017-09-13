class AddFieldsToCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :authorization, :string
    add_column :checkouts, :message, :string
    add_column :checkouts, :success, :string
  end
end
