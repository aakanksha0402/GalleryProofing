class AddFieldToPermission < ActiveRecord::Migration
  def change
    add_column :permissions, :permission_name, :string
  end
end
