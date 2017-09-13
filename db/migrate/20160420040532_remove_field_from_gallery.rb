class RemoveFieldFromGallery < ActiveRecord::Migration
  def change
    remove_column :galleries, :cover_url, :string
  end
end
