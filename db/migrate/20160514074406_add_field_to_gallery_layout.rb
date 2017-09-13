class AddFieldToGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :gallery_layouts, :category, index: true, foreign_key: true
  end
end
