class AddFieldToPermissionActionPermissionSections < ActiveRecord::Migration
  def change
    add_column :permission_action_permission_sections, :section_name, :string
  end
end
