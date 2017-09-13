class AddIsHiddenFieldToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :is_hidden, :boolean, default: false
  end
end
