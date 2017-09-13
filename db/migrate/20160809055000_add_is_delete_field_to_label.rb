class AddIsDeleteFieldToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :is_delete, :boolean, default: false
  end
end
