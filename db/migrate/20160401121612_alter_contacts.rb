class AlterContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :address1, :string
    add_column :contacts, :address2, :string
    remove_column :contacts, :address, :string
  end
end
