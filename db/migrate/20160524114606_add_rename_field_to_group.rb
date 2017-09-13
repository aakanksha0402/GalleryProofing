class AddRenameFieldToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :rename, :string
  end
end
