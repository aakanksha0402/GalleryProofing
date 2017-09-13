class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.references :gallery, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
