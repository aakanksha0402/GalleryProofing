ActiveAdmin.register ItemListSubItem do
  menu priority: 7

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
  index do
    column :id
    column "Item List",:item_list_id do |i|
      "#{i.item_list.size_one} ✕ #{i.item_list.size_two}"
    end
    column "Sub Item",:sub_item_id do |s|
      s.sub_item.name
    end
    column :created_at
    actions
  end
  form do |f|
    f.inputs do
      f.semantic_errors # shows errors on :base
      f.input :item_list_id , label: "ITEM LIST",:as => :select,:collection => ItemList.all.map{|c| ["#{c.size_one} ✕ #{c.size_two}",c.id]}
      f.input :sub_item_id, label: "SUB ITEM", :as => :select,:collection => SubItem.all.map{|c| [c.name,c.id]}
    end      # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  filter :item_list_id , label: "ITEM LIST",:as => :select#,:collection => ItemList.all.map{|c| ["#{c.size_one} ✕ #{c.size_two}",c.id]}
  filter :sub_item_id, label: "SUB ITEM", :as => :select#,:collection => SubItem.all.map{|c| [c.name,c.id]}
  filter :created_at

  controller do
    #...
    def permitted_params
      params.permit(:item_list_sub_item => [:item_list_id, :sub_item_id])
      # params.permit! # allow all parameters
    end
  end
end
