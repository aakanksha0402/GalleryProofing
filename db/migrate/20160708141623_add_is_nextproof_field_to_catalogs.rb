class AddIsGalleryproofFieldToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :is_galleryproofing, :boolean, default: true
  end
end
