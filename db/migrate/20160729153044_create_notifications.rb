class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_from
      t.integer :id_from
      t.references :brand, index: true, foreign_key: true
      t.boolean :is_dismiss

      t.timestamps null: false
    end
  end
end
