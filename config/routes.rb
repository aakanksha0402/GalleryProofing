Rails.application.routes.draw do

  get 'mobileapps/:brand_id/:mobileapp_id/show_app', to: 'mobileapps#show_app', as: :show_app
  post "mobileapps/save_share_link" => 'mobileapps#save_share_link', :as => :save_share_link
  get "mobileapps/share_link" => 'mobileapps#share_link', :as => :share_link
  get "mobileapps/add_theme" => 'mobileapps#add_theme', :as => :add_theme
  delete 'mobileapps/:customlink_id/:mobileapp_id/delete_link', to: 'mobileapps#delete_link', as: :delete_link
  post "mobileapps/update_link" => 'mobileapps#update_link', :as => :update_link
  post "mobileapps/add_link" => 'mobileapps#add_link', :as => :add_link
  delete 'mobileapps/:image_id/:mobileapp_id/delete_image', to: 'mobileapps#delete_image', as: :delete_image
  post "mobileapps/save_photos" => 'mobileapps#save_photos', :as => :save_photos
  get "mobileapps/add_photos" => 'mobileapps#add_photos', :as => :add_photos
  get "mobileapps/change_icon" => 'mobileapps#change_icon', :as => :change_icon
  resources :mobileapps do
    collection do
        get "change_view_type"
        get "set_icon"
        get "layout_language_mobile"
    end
  end

  resources :song_libraries
  resources :dashboards do
    collection do
      post 'dismiss'
      get 'recent_gallery_activity'
    end
  end
  resources :notifications do
    member do
      patch :update_dismiss
      put :update_dismiss
      post :dismiss_notification
    end
  end
  # put "notifications/update_dismiss"

  resources :default_email_template_types

  get ':brand/gallery/:gallery/checkout', to: "checkouts#checkout", as: "checkout"

  get 'reports/gallery_visitors'
  get 'reports/sales'
  get 'reports/orders'
  get 'reports/ordered_files'
  get 'reports/items'
  get 'reports/invoice_payments'
  get 'reports/client_email_cart'

  post 'checkouts/get_states'

  post 'checkouts/update/:id', :to => 'checkouts#update', :as => :update_checkout
  post 'checkouts/get_shipping'
  post 'checkouts/remove_shipping'
  post 'checkouts/apply_shipping'
  post ':brand/gallery/:gallery/checkout', to: "checkouts#create", as: "create"
  get ':brand/gallery/:gallery/checkout/paypalbump', to: "checkouts#paypalbump", as: "paypalbump"

  get 'checkouts/index'

  resources :invoice_line_items do
    collection do
      get 'save_invoice_line_item'
      get 'item_update'
      post 'update_details'
      get 'delete_line_item'
    end
  end
  resources :invoices do
    collection do
      get 'contact_suggestions'
      get 'existing_contact'
      get 'state_list'
      post 'save_payment'
      post 'send_invoice'
      get 'invoice_email'
      get 'line_item_suggestion'
      post 'send_invoice_email'
      get 'client_view'
    end
  end
  resources :invoice_template do
    collection do
      get 'show_items'
      get 'delete_template'
      get 'delete_invoice_template'
    end
  end
  resources :line_item

  resources :watermarks
  post "watermarks/apply_default"
  post "watermarks/default_set"

  post 'carts/add_promocode' , to: "carts#add_promocode", as: "add_promocode"
  post 'carts/save_email'
  post 'carts/verify_email'

  get 'carts/alter_quantity_in_cart/:line_item_id', to: "carts#alter_quantity_in_cart", as: "alter_quantity_in_cart"

  get 'carts/reduce_quantity/:line_item_id', to: "carts#reduce_quantity", as: "reduce_form_cart"

  get 'carts/increase_quantity/:line_item_id', to: "carts#increase_quantity", as: "increase_in_cart"

  get 'carts/remove_an_item/:line_item_id', to: "carts#remove_an_item",as: "remove_form_cart"

  post 'carts/empty_cart'
  post 'carts/remove_promocode'
  post 'carts/update_cart_item'
  post 'carts/add_to_cart'

  get 'view_items/:brand/:gallery/:photo', to: "carts#view_items", as: "view_items"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post 'albums/update_cover'
  resources :photos

  #use_doorkeeper is used for implemenent Oauth2 for api authentication
  use_doorkeeper

  resources :photos
  resources :music_plans

  resources :music_categories
  resources :songs do
    collection do
      post 'get_prices'
      post 'subscribe'
    end
  end

  resources :pricings do
    collection do
      post 'duplicate_pricesheet'
      get 'digital_media'
    end
  end

  resources :discounts do
    collection do
      get 'save_discount'
      post 'save_discount'
      get 'update_name'
      patch 'update_name'
      get 'edit_discounts'
      post 'edit_discounts'
      post 'update_discount'
    end
  end

  resources :playlists do
    collection do
      post 'add_song_to_playlist'
      post 'remove_song_from_playlist'
      get 'user_music'
    end
  end

  resources :musics

  post 'catalogs/create'

  post 'user_permissions/activate_user'

  post 'user_permissions/deactivate_user'

  resources :user_permissions
  get 'groups/find_records'
  get 'catalogs/update_description'
  patch 'catalogs/update_description'
  get 'groups/add_description'
  post 'groups/add_description'
  get 'groups/delete_item'
  post 'groups/delete_item'
  get 'groups/delete_group'
  post 'groups/delete_group'
  get 'groups/rename_group'
  post 'groups/rename_group'

  post 'albums/password_generate'
  post 'albums/set_password'
  get 'galleries/update_cover'
  get 'plans_billings/planbilling'
  post 'plans_billings/changeplan'
  get 'plans_billings/creditcard'
  post 'plans_billings/chargecreditcard'
  get 'plans_billings/print_invoice'


  resources :data_plans
  get "album_photos/travel"
  get "galleries/remove_cover_pic"
  post "galleries/remove_cover_pic"
  get "albums/remove_cover_pic"
  post "albums/remove_cover_pic"
  get "galleries/fileinput"


  # get "albums/test"
  post "albums/test"
  get "gallery_layouts/set_default"
  get "albums/albumlist"

  get 'refer_friends/refer'
  post 'refer_friends/send_email'

  resources :gallery_visitors do
    collection do
      get 'delete_gallery_visitor'
      post 'delete_gallery_visitor'
    end
  end

  post 'views/show_modal'

  get 'views/facebook_sharing' => 'views#facebook_sharing', :as => :facebook_sharing
  get 'views/social_sharing' => 'views#social_sharing', :as => :social_sharing
  get 'views/download_zip' => 'views#download_zip', :as => :download_zip
  post 'views/check_email' => 'views#check_email', :as => :check_email
  get 'views/:gallery_visitor_id/verify_mail', to: 'views#verify_mail', as: :verify_mail
  get 'views/download_all_photo' => 'views#download_all_photo', :as => :download_all_photo
  get 'views/without_pin' => 'views#without_pin', :as => :without_pin
  post 'views/required_pin' => 'views#required_pin', :as => :required_pin
  get 'views/download_digital'
  post 'views/save_download_session'
  get ':brand/gallery/:gallery/album/:album/detail/views/image_load' , to: "views#image_load" , :as=> :image_load
  get ':brand/gallery/:gallery/album/:album/detail/views/hide_unhide' , to: "views#hide_unhide" , :as=> :hide_unhide
  get 'views/hide_unhide'
  get 'views/setlabels'

  # get 'view_home_page', to: "views", as: 'view',constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' },:path => '/'
  get 'view_home_page/:brand', to: "views#view_home_page", as: 'view'

  # get 'custom_link/:custom_link', to: 'views#custom_link', as: "view_gallery_link", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  # get 'gallery/:gallery', to: 'views#gallery', as: "view_gallery", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get ':brand/gallery/:gallery', to: 'views#gallery', as: "view_gallery"

  # get 'category/:category', to: 'views#category', as: "view_category", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get ':brand/category/:category', to: 'views#category', as: "view_category"

  # get 'view_galleries', to: "views",constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  # get 'gallery/:gallery/home', to: 'views#home', as: "view_home", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get ':brand/gallery/:gallery/home', to: 'views#home', as: "view_home"

  # get 'gallery/:gallery/info/pricing', to: 'views#pricing', as: "view_pricing", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get ':brand/gallery/:gallery/info/pricing', to: 'views#pricing', as: "view_pricing"

  get ':brand/gallery/:gallery/info/contact', to: 'views#contact', as: "view_contact"
  # get 'gallery/:gallery/info/contact', to: 'views#contact', as: "view_contact", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }


  # get 'gallery/:gallery/album/:album', to: 'views#album', as: "view_album", constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get ':brand/gallery/:gallery/album/:album', to: 'views#album', as: "view_album"

  # get 'gallery/:gallery/favorites', to: "favorites#all_favorites", as: "view_favorite"
  get ':brand/gallery/:gallery/favorites', to: "favorites#all_favorites", as: "view_favorite"

  get ':brand/gallery/:gallery/carts', to: "carts#view_cart", as: "view_cart"


#  get ':brand/gallery/:gallery/photo/:photo', to: "views#gallery_slider", as: "gallery_slider"

  get ':brand/gallery/:gallery/album/:album/detail/:photo', to: "views#gallery_slider", as: "gallery_slider"

  post 'favorites/add_favorite'

  post 'favorites/remove_favorite'
  post 'favorites/check_favorites_mail' => 'favorites#check_favorites_mail', :as => :check_favorites_mail
  get 'favorites/:gallery_visitor_id/verify_favorites_mail/:brand_id', to: 'favorites#verify_favorites_mail', as: :verify_favorites_mail
  post 'favorites/verify_email'

  post 'favorites/share_fav'

  get 'favorites/test'
  # get 'home', to: "views"
  # get 'view_categories', to: "views"
  post 'views/album_password'
  post 'views/gallery_password'
  post 'views/view_widget'
  post 'views/galleries_password'
  post 'views/galleries_password_visitors'
  post 'views/get_password'
  post 'views/get_both'
  post 'views/access_code'


  get 'studio_home_pages/view'
  get 'galleries/sample'
  get "galleries/all_delete"
  get "galleries/download_all"
  get "galleries/delete_selected"
  get "galleries/find_image"
  post "galleries/rename_image"
  get "galleries/selected_download"
  post "galleries/download_all_favorites"
  get "galleries/share_details"
  post "galleries/share_details"
  put "galleries/share_details"
  get "galleries/remove_link_contact"

  resources :studio_home_pages
  get 'categories/name'
  resources :categories do
    put :sort, on: :collection
  end
  get "galleries/cover"
  get "color_logos/mobile_iframe"
  post "color_logos/check_for_errors"
  resources :color_logos
  get 'galleries/bulkaction'
  post 'galleries/rename'
  get 'automation_series/remove_template_from_series'
  resources :automation_series_email_templates
  resources :automation_series
  resources :default_trigger_types
  resources :default_receipient_types
  resources :album_photos
  get 'albums/albumhome'
  post 'albums/albumhome'
  get 'albums/add_photos'
  post 'albums/save_photos'
  resources :albums do
    get "load_images"
      collection do
          get "download_mail_send"
          get "gallery_load_images"
          post "share_details"
          get "showalbum"
        end
  end
  get 'galleries/download'
  get 'galleries/filelist'
  post 'galleries/update_multiple'
  resources :gallery_photos do
      collection do

      end
  end

  get "default_email_templates/get_json"
  post "email_templates/new_template"
  resources :email_templates do
    collection do
      get 'email_activity'
    end
  end
  resources :default_email_templates
  resources :custom_gallery_layouts
  get 'galleries/addgallery'
  post 'galleries/galleryhome'
  post 'galleries/hide_album_photos'
  get 'galleries/addphotos'
  get 'galleries/addcontact'
  post 'galleries/add_link_with_contact'
  get 'gallery_layouts/addset'
  get 'gallery_layouts/layoutlist'
  get 'contacts/duplicate'
  # get 'main_pages/home'
  # get 'main_pages/profile'
  # post 'main_pages/update'
  get 'dashboards/reset_password'
  # get 'main_pages/reset_password'

  get 'galleries/galleryhome'

  post 'brands/change_brand'
  resources :brands do
    collection do
     get 'get_states'
   end
  end
  resources :orders do
    collection do
      get 'mail_sent'
      get 'bulkaction'
      post 'bulkaction'
      post 'status_change'
    end
  end
  resources :groups do
    collection do
      get 'update_custom_item'
      post 'add_terms_of_sale'
      get 'adding_shipping_option'
      get 'delete_shipping_option'
      get 'update_shipping_details'
      get 'show_group'
      get 'self_fulfillment'
      post 'self_fulfillment'
      put 'update_selffulfillment'
      get 'edit_items' => 'groups#item_edit'
      put 'edit_items' => 'groups#item_update'
      delete 'edit_items' => 'groups#item_delete'
      get 'test_page'
      get 'print'
      get 'show_group1'
    end
  end
  resources :gateway_setups do
    collection do
      post 'setup'
      get 'test_setup'
    end
  end
  resources :posts do
    collection do
      get 'categoryshow'
    end
  end

  get 'galleries/add_photos'
  post 'galleries/save_photos'
  resources :galleries do
    collection do
      get "hide_album_photos"
      post "create_watermark"
      get "contactdetails"
      get "client_mail_favorites"
      get "client_email_labeled"
      get "contact_settings"
      post "save_privilege"
      patch "save_privilege"
      post "delete_hidden_photos"
      get "remove_label"
      get "delete_label"
      get "change_view_type"
      get "download_mail_send"
      get "download_link"
      get "download_page"
      get "load_images"
      get "album_download_link"
      get "showgallery"
      get "remove_from_album"
    end
    member do
      post "save_privilege"
    end
  end

  resources :gallery_layouts
  resources :contacts
  resource :users, only: [:edit] do
    collection do
      patch 'update_profile'
    end
  end
  devise_for :users, :controllers => { registrations: 'registrations', passwords: 'passwords', sessions: 'sessions', users: 'users' }

  root 'dashboards#index'
  # root 'main_pages#home'



  namespace :oauth , :path => nil do
    get "oauth/login" => "oauth#login" , :as => :oauth_login
    get "oauth/new" => "oauth#new" , :as => :oauth_new
    post "oauth/login_attempt" => "oauth#login_attempt" , :as => :login_attempt
    get "oauth/show_code" => "oauth#show_code" , :as => :show_code
  end


  #Api routes

  namespace :api, defaults: {format: 'json'}do
    namespace :v1 do

      #brands routes
      # resources :brands ,only: [:index, :create]  do
      #   collection do
      #     get :info
      #     get :get_event_defaults
      #     get :get_event_tree
      #   end
      # end

      get "brands/get_list" => "brands#get_list" , :as => :brand_get_list
      post "brands/create" => "brands#create" , :as => :create_brand
      get "brands/info" => "brands#info" , :as => :brand_info
      get "brands/get_event_defaults" => "brands#get_event_defaults" , :as => :brand_get_event_defaults
      get "brands/get_event_tree" => "brands#get_event_tree" , :as => :brand_get_event_tree


      #events routes
      get  "events/get_list" => "events#get_list" , :as => :get_list
      post "events/create" => "events#create" , :as => :create_event
      post "events/update" => "events#update" , :as => :update_event
      post "events/delete" => "events#delete" , :as => :delete_event
      post "events/rename" => "events#rename" , :as => :rename_event
      post "events/set_access_level" => "events#set_access_level" ,:as => :set_access_level
      get  "events/photo_exists" => "events#photo_exists" , :as => :photo_exists
      get  "events/get_photos" => "events#get_photos" , :as => :get_photos
      post "events/set_category" => "events#set_category" , :as => :set_category
      post "events/set_contact" => "events#set_contact" , :as => :set_contact
      get  "events/gallery_visitors" => "events#gallery_visitors" , :as => :gallery_visitors

      #category routee
      get  "category/get_list" => "categories#get_list" , :as => :category_get_list
      post "category/create" => "categories#create" , :as => :create_category
      post "category/rename" => "categories#rename" , :as => :rename_category

      #albums routes
      get  "albums/get_list" => "albums#get_list" ,:as => :albums_get_list
      post "albums/create" => "albums#create" , :as => :create_album
      post "albums/delete" => "albums#delete" , :as => :delete_album
      post "albums/move"  => "albums#move"  , :as => :move_album
      post "albums/rename" => "albums#rename" , :as => :rename_album
      get  "albums/get_photos" => "albums#get_photos" , :as => :get_albums_photos

      #photos routes
      post "photos/upload" => "photos#upload" , :as => :upload_photo
      post "photos/add_to_album" => "photos#add_to_album" , :as => :add_to_album
      post "photos/remove_from_album" => "photos#remove_from_album" , :as => :remove_from_album
      get  "photos/info" => "photos#info" , :as => :photo_info
      post "photos/delete" => "photos#delete" , :as => :delete_photo
      post "photos/update" => "photos#update" , :as => :update_photo


      #contact routes
      get  "contacts/info" => "contacts#info" , :as => :contact_info
      post "contacts/create" => "contacts#create" , :as => :create_contact
      post "contacts/update" => "contacts#update" , :as => :update_contact
      post "contacts/delete" => "contacts#delete", :as => :delete_contact
      post "contacts/bulk_create" => "contacts#bulk_create", :as => :bulk_create
      get  "contacts/get_event_list" =>"contacts#get_event_list", :as => :get_event_list

      #authorization
      get 'auth/deauthorize' => "auth#deauthorize" , :as => :deauthorize
      match '/' => 'brands#index', :as => :root ,via: [:get,:post]
    end
  end
end
