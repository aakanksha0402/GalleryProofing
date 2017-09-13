class AddViewTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :view_type, :boolean, :default => true
  end
end
