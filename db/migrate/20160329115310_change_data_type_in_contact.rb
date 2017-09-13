class ChangeDataTypeInContact < ActiveRecord::Migration
  def up
    change_column :contacts, :phone_number, :string
  end
  def down
    change_column :contacts, :phone_number, :integer
  end
end
