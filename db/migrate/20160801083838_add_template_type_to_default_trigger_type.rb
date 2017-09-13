class AddTemplateTypeToDefaultTriggerType < ActiveRecord::Migration
  def change
    add_reference :default_trigger_types, :default_email_template_type, index: {name: "triiger_template_type"}, foreign_key: true
  end
end
