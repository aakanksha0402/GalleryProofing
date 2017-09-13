class RenameTypeFieldInDepositType < ActiveRecord::Migration
  def change
    rename_column :deposit_types, :type, :deposit_type
  end
end
