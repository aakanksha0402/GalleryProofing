class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :permission_action_permission_section, index: true, foreign_key: true
      t.boolean :value
      t.string :user_id

      t.timestamps null: false
    end
  end
end
