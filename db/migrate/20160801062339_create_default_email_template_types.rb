class CreateDefaultEmailTemplateTypes < ActiveRecord::Migration
  def change
    create_table :default_email_template_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
