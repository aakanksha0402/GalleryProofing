class CreatePermissionSections < ActiveRecord::Migration
  def change
    create_table :permission_sections do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
