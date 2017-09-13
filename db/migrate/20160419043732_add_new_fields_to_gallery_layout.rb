class AddNewFieldsToGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :gallery_layouts, :pricing, index: true, foreign_key: true
    add_reference :gallery_layouts, :automation_series, index: true, foreign_key: true
    add_column :gallery_layouts, :visitor_info, :text
  end
end
