class CreatePermissionActions < ActiveRecord::Migration
  def change
    create_table :permission_actions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
