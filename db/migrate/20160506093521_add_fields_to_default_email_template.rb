class AddFieldsToDefaultEmailTemplate < ActiveRecord::Migration
  def change
    add_column :default_email_templates, :text_after_select, :string
    add_column :default_email_templates, :text_for_button, :string
  end
end
