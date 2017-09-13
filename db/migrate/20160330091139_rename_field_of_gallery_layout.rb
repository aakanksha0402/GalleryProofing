class RenameFieldOfGalleryLayout < ActiveRecord::Migration
  def change
    change_column :gallery_layouts, :pickup_option,  :string
  end
end
