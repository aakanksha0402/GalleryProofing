class AddBrandToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :brand, index: true, foreign_key: true
  end
end
