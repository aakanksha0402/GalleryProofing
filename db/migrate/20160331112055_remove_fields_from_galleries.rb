class RemoveFieldsFromGalleries < ActiveRecord::Migration
  def change
    remove_column :galleries, :release_date, :date
    remove_column :galleries, :expiration_date, :date
    remove_reference :galleries, :user, index: true, foreign_key: true
  end
end
