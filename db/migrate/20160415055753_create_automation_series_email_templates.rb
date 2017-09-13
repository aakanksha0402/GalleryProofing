class CreateAutomationSeriesEmailTemplates < ActiveRecord::Migration
  def change
    create_table :automation_series_email_templates do |t|
      t.references :automation_series, index: {name: "automation_series_id"}, foreign_key: true
      t.references :email_template, index: {name: "email_template_id"}, foreign_key: true
      t.references :default_receipient_type, index: {name: "receipient_id"}, foreign_key: true
      t.references :default_trigger_type, index: {name: "trigger_id"}, foreign_key: true
      t.integer :trigger_days
      t.string :template_name

      t.timestamps null: false
    end
  end
end
