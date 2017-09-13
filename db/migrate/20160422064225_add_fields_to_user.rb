class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :studio_name, :string
    add_reference :users, :country, index: true
  end
end
