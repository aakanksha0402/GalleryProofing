class CreateGalleryLayouts < ActiveRecord::Migration
  def change
    create_table :gallery_layouts do |t|
      t.string :name
      t.string :introduction_page_layout
      t.string :photo_page_layout
      t.string :status
      t.string :gallery_access_privacy
      t.string :password
      t.boolean :email_require
      t.boolean :cropping
      t.boolean :preregistration
      t.boolean :black_and_white_filtering
      t.string :studio_link
      t.boolean :show_filename
      t.boolean :social_sharing_link
      t.string :content
      t.integer :min_order
      t.boolean :add_photo_to_cart
      t.boolean :pay_later
      t.boolean :pickup_option
      t.string :checkout_message
      t.boolean :digital_download
      t.boolean :entire_gallery_download
      t.boolean :hide_photos
      t.string :archiving
      t.boolean :is_default

      t.timestamps null: false
    end
  end
end
