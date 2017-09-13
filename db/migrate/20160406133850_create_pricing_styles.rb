class CreatePricingStyles < ActiveRecord::Migration
  def change
    create_table :pricing_styles do |t|
      t.string :name
      t.boolean :is_deleted

      t.timestamps null: false
    end
  end
end
