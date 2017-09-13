class AddFieldsToReferredContacts < ActiveRecord::Migration
  def change
    add_column :referred_contacts, :reference_contact_id, :string
  end
end
