json.array!(@studio_home_pages) do |studio_home_page|
  json.extract! studio_home_page, :id, :subdomain, :color_logo_id, :homepage_layout, :event_list, :email_field, :sort_on, :about, :fb_url, :twitter_username, :intagram_username, :pinterest_username, :show_about, :show_phone, :show_address, :show_email, :show_website_link, :brand_id
  json.url studio_home_page_url(studio_home_page, format: :json)
end
