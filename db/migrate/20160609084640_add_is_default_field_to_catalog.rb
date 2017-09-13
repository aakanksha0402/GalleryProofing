class AddIsDefaultFieldToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :is_default, :boolean
  end
end
