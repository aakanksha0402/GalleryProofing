class AddTemplateTypeToDefaultReceipientType < ActiveRecord::Migration
  def change
    add_reference :default_receipient_types, :default_email_template_type, index: {name: "receipient_email_type"}, foreign_key: true
  end
end
