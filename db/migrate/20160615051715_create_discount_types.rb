class CreateDiscountTypes < ActiveRecord::Migration
  def change
    create_table :discount_types do |t|
      t.string :type_name
      t.string :description

      t.timestamps null: false
    end
  end
end
