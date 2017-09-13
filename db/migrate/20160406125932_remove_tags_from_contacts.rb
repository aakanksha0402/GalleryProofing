class RemoveTagsFromContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :tags
  end
end
