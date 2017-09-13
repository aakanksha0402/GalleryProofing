class CreateDepositTypes < ActiveRecord::Migration
  def change
    create_table :deposit_types do |t|
      t.string :type

      t.timestamps null: false
    end
  end
end
