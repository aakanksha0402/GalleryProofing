class AddFieldToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :resolution, :integer
  end
end
