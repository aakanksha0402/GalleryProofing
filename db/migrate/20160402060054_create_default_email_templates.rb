class CreateDefaultEmailTemplates < ActiveRecord::Migration
  def change
    create_table :default_email_templates do |t|
      t.string :email_type
      t.string :email_subject
      t.string :headline
      t.string :button_text
      t.string :email_body

      t.timestamps null: false
    end
  end
end
