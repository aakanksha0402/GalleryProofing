class AddSubUserDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :boolean, default: true
    add_column :users, :studio_id, :string
  end
end
