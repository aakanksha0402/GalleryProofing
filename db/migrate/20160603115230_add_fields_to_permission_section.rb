class AddFieldsToPermissionSection < ActiveRecord::Migration
  def change
    add_reference :permission_sections, :section, index: true, foreign_key: true
  end
end
