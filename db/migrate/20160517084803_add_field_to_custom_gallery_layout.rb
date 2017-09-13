class AddFieldToCustomGalleryLayout < ActiveRecord::Migration
  def change
    add_column :custom_gallery_layouts, :require_PIN, :boolean
    add_column :custom_gallery_layouts, :PIN, :string
  end
end
