json.array!(@gallery_layouts) do |gallery_layout|
  json.extract! gallery_layout, :id, :name, :introduction_page_layout, :photo_page_layout, :status, :custom_link, :gallery_access_privacy, :password, :email_require, :cropping, :preregistration, :black_and_white_filtering, :studio_link, :show_filename, :social_sharing_link, :content, :min_order, :add_photo_to_cart, :pay_later, :pickup_option, :checkout_message, :digital_download, :entire_gallery_download, :hide_photos, :archiving, :is_default
  json.url gallery_layout_url(gallery_layout, format: :json)
end
