class AddIsDeleteFieldToGalleryVisitor < ActiveRecord::Migration
  def change
    add_column :gallery_visitors, :is_delete, :boolean, default: false
  end
end
