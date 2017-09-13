ActiveAdmin.register MusicLibrary do

  permit_params :title, :singer, :theme, :released_date, :music, :photo

  form :html => { :enctype => "multipart/form-data" } do |f|
   f.inputs "Musics" do
    f.input :title
    f.input :singer
    f.input :theme
    f.input :released_date, as: :datepicker
    f.input :music, :as => :file
    f.input :photo, :as => :file
  end
  f.button :"Upload Music"
 end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
