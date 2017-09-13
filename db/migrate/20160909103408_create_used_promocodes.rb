class CreateUsedPromocodes < ActiveRecord::Migration
  def change
    create_table :used_promocodes do |t|
      t.string :promocode
      t.references :cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
