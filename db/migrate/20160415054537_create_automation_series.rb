class CreateAutomationSeries < ActiveRecord::Migration
  def change
    create_table :automation_series do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
