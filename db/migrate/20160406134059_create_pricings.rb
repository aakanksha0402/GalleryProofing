class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.string :name
      t.boolean :is_deleted
      t.references :user, index: true, foreign_key: true
      t.references :pricing_style, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
