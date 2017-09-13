class AddFieldsToGalleries < ActiveRecord::Migration
  def change
    add_reference :galleries, :brand, index: true, foreign_key: true
  end
end
