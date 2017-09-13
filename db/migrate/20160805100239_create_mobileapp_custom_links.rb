class CreateMobileappCustomLinks < ActiveRecord::Migration
  def change
    create_table :mobileapp_custom_links do |t|
      t.string :link

      t.timestamps null: false
    end
  end
end
