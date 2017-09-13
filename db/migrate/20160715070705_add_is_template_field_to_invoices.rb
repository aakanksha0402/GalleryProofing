class AddIsTemplateFieldToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :is_template, :boolean, default: false
    add_column :invoices, :template_name, :string
  end
end
