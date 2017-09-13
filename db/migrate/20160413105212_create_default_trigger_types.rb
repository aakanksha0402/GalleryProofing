class CreateDefaultTriggerTypes < ActiveRecord::Migration
  def change
    create_table :default_trigger_types do |t|
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
