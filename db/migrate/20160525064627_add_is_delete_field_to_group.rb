class AddIsDeleteFieldToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :is_delete, :boolean, default: false
  end
end
