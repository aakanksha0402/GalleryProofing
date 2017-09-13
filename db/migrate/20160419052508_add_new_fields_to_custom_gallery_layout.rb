class AddNewFieldsToCustomGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :custom_gallery_layouts, :pricing, index: true, foreign_key: true
    add_reference :custom_gallery_layouts, :automation_series, index: true, foreign_key: true
    add_column :custom_gallery_layouts, :visitor_info, :text
  end
end
