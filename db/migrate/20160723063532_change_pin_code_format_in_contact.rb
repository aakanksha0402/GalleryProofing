class ChangePinCodeFormatInContact < ActiveRecord::Migration
  def up
    change_column :contacts, :pincode, :string
    change_column :contacts, :pincode, :string
  end

  def down
    change_column :contacts, :pincode, :integer
    change_column :contacts, :pincode, :integer
  end
end
