json.array!(@mobileapps) do |mobileapp|
  json.extract! mobileapp, :id, :name, :contact_info, :social_sharing, :layout, :language, :mobileapp_photo_id, :color_logo_id, :mobileapp_custom_link_id, :gallery_id
  json.url mobileapp_url(mobileapp, format: :json)
end
