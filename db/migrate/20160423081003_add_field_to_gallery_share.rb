class AddFieldToGalleryShare < ActiveRecord::Migration
  def change
    add_reference :gallery_shares, :gallery, index: true, foreign_key: true
  end
end
