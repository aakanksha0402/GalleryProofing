ActiveAdmin.register DataPlan, as: "Plan" do
  menu priority: 4

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :photos_number, :mobile_apps_number, :invoices_number, :data_period, :plan_price
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column "Photos",:photos_number
    column "Mobile Apps",:mobile_apps_number
    column "Invoicing",:invoices_number
    column :data_period
    column :plan_price
    column :created_at
    column :updated_at
    actions
  end
  filter :created_at
  filter :photos_number, label: 'Photos'
  filter :mobile_apps_number, label: 'Mobile Apps',:as => :select
  filter :data_period,:as => :select
  filter :plan_price
  

end
