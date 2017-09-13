class CreatePermissionActionPermissionSections < ActiveRecord::Migration
  def change
    create_table :permission_action_permission_sections do |t|
      t.references :permission_action, index: {name: "action_id"}, foreign_key: true
      t.references :permission_section, index: {name: "section_id"}, foreign_key: true
      t.boolean :value
      t.string :name
      t.timestamps null: false
    end
  end
end
