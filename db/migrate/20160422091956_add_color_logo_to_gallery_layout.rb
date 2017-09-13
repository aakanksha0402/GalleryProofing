class AddColorLogoToGalleryLayout < ActiveRecord::Migration
  def change
    add_reference :gallery_layouts, :color_logo, index: true, foreign_key: true
  end
end
