class AddFieldsToGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :gallery_layouts, :user, index: true, foreign_key: true
  end
end
