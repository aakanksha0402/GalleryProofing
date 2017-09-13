class AddBrandToAutomationSeries < ActiveRecord::Migration
  def change
    add_reference :automation_series, :brand, index: true, foreign_key: true
  end
end
