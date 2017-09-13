class RemoveFieldsFromGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :gallery_layouts, :brand, index: true, foreign_key: true
    
  end
end
