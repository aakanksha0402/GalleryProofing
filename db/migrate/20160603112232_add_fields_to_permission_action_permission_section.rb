class AddFieldsToPermissionActionPermissionSection < ActiveRecord::Migration
  def up
    add_reference :permission_action_permission_sections, :section, index: true, foreign_key: true
    remove_column :permission_action_permission_sections, :section_name
  end
end
