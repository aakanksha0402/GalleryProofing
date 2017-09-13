class AddIsDeleteToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :is_delete, :boolean, :default => false
  end
end
