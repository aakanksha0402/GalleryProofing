class CreateCountryLabs < ActiveRecord::Migration
  def change
    create_table :country_labs do |t|
      t.references :country, index: true, foreign_key: true
      t.references :lab, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
