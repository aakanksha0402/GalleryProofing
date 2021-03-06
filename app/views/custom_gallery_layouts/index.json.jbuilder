json.array!(@custom_gallery_layouts) do |custom_gallery_layout|
  json.extract! custom_gallery_layout, :id, :name, :introduction_page_layout, :photo_page_layout, :status, :custom_link, :release_date, :expiration_date, :gallery_access_privacy, :password, :email_require, :cropping, :preregistration, :black_and_white_filtering, :studio_link, :show_filename, :social_sharing_link, :content, :min_order, :add_photo_to_cart, :pay_later, :pickup_option, :checkout_message, :digital_download, :entire_gallery_download, :hide_photos, :archiving, :is_default, :brand
  json.url custom_gallery_layout_url(custom_gallery_layout, format: :json)
end
