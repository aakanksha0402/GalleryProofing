class AddFieldsToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :parent, :integer
    add_column :albums, :level, :integer
  end
end
