ActiveAdmin.register ItemList do
  menu priority: 6

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :size_one,:size_two,:depth,:fix_group_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  index do
    column :id
    column  "Item Size" do |i|
      "#{i.size_one} ✕ #{i.size_two}"
    end
    column :depth
    column "Group",:fix_group_id do |g|
      g.fix_group.name
    end
    column :created_at
    actions
  end
  form do |f|
    f.inputs do
      f.semantic_errors # shows errors on :base
      f.input :size_one 
      f.input :size_two
      f.input :depth
      f.input :fix_group_id, :as => :select,:collection => FixGroup.where("name ='Prints' OR name = 'Canvases'").map{|c| [c.name,c.id]}
    end      # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  filter :size_one
  filter :size_two
  filter :depth
  filter :created_at
  filter :fix_group_id, :as => :select,:collection => proc {FixGroup.where("name ='Prints' OR name = 'Canvases'").map{|c| [c.name,c.id]}}
  

end
