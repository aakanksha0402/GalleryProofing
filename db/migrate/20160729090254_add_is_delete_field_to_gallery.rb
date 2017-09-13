class AddIsDeleteFieldToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :is_delete, :boolean, default: false
  end
end
