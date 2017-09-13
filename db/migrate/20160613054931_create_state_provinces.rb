class CreateStateProvinces < ActiveRecord::Migration
  def change
    create_table :state_provinces do |t|
      t.references :country, index: true, foreign_key: true
      t.string :name
      t.string :abbrevation
      t.boolean :is_deleted,default: false

      t.timestamps null: false
    end
  end
end
