class AddColorLogoToCustomGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :custom_gallery_layouts, :color_logo, index: true, foreign_key: true
  end
end
