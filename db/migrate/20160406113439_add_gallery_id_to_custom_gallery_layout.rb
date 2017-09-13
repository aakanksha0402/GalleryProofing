class AddGalleryIdToCustomGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :custom_gallery_layouts, :gallery, index: true, foreign_key: true
  end
end
