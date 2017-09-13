class AddNameToColorLogo < ActiveRecord::Migration
  def change
    add_column :color_logos, :name, :string
  end
end
