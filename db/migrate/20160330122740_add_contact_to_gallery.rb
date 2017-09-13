class AddContactToGallery < ActiveRecord::Migration
  def change
    add_reference :galleries, :contact, index: true, foreign_key: true
    add_reference :galleries, :gallery_layout, index: true, foreign_key: true
  end
end
