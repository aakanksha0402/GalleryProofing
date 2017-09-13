class CreateFixGroups < ActiveRecord::Migration
  def change
    create_table :fix_groups do |t|
      t.string :name
      t.boolean :is_deleted

      t.timestamps null: false
    end
  end
end
