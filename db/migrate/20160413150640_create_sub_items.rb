class CreateSubItems < ActiveRecord::Migration
  def change
    create_table :sub_items do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
