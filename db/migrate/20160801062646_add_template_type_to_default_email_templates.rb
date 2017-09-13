class AddTemplateTypeToDefaultEmailTemplates < ActiveRecord::Migration
  def change
    add_reference :default_email_templates, :default_email_template_type, index: true, foreign_key: true
  end
end
