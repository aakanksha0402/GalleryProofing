class AddCategoryToCustomGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :custom_gallery_layouts, :category, index: true, foreign_key: true
  end
end
