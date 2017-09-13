class AddFieldsToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :password, :string
  end
end
