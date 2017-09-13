class AddUserIdToCustomGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :custom_gallery_layouts, :user, index: true, foreign_key: true
  end
end
