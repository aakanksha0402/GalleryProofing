class AlterFieldsOfCatalogs < ActiveRecord::Migration
  def change
    rename_column :catalogs, :type, :catalog_type
    change_column_default :catalogs, :checked, false
  end
end
