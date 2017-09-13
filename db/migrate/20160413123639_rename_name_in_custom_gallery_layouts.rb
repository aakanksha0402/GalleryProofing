class RenameNameInCustomGalleryLayouts < ActiveRecord::Migration
  def change
    rename_column :custom_gallery_layouts, :name, :layout_name
  end
end
