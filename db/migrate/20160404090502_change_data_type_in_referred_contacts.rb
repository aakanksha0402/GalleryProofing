class ChangeDataTypeInReferredContacts < ActiveRecord::Migration
  def up
    change_column :referred_contacts, :reference_contact_id, 'integer USING CAST(reference_contact_id AS integer)'
  end

  def down
    def change
      change_column :referred_contacts, :reference_contact_id, :string
    end
  end
end
