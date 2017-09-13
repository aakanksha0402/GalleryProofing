class RemoveFieldsFromCustomGalleryLayout < ActiveRecord::Migration
  def change
    remove_column :custom_gallery_layouts, :custom_link, :string
    remove_column :custom_gallery_layouts, :release_date, :date
    remove_column :custom_gallery_layouts, :expiration_date, :date
    remove_column :custom_gallery_layouts, :status, :string
  end
end
