class AddFieldToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :custom_link, :string
    add_column :galleries, :release_date, :date
    add_column :galleries, :expiration_date, :date
    add_column :galleries, :status, :string
  end
end
