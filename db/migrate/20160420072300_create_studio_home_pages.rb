class CreateStudioHomePages < ActiveRecord::Migration
  def change
    create_table :studio_home_pages do |t|
      t.string :subdomain
      t.references :color_logo, index: true, foreign_key: true
      t.string :homepage_layout
      t.boolean :event_list
      t.boolean :email_field
      t.string :sort_on
      t.string :about
      t.string :fb_url
      t.string :twitter_username
      t.string :intagram_username
      t.string :pinterest_username
      t.boolean :show_about
      t.boolean :show_phone
      t.boolean :show_address
      t.boolean :show_email
      t.boolean :show_website_link
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
