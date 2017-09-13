class AddNotesToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :notes, :string
  end
end
