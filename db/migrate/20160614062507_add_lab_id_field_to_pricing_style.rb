class AddLabIdFieldToPricingStyle < ActiveRecord::Migration
  def change
    add_column :pricing_styles, :lab_id, :integer
  end
end
