class AddContactIdFieldToClientContact < ActiveRecord::Migration
  def change
    add_column :client_contacts, :contact_id, :integer
  end
end
