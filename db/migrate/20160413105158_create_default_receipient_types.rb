class CreateDefaultReceipientTypes < ActiveRecord::Migration
  def change
    create_table :default_receipient_types do |t|
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
