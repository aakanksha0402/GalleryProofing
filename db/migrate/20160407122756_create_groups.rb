class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :fix_group, index: true, foreign_key: true
      t.string :name
      t.boolean :is_deleted
      t.references :pricing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
