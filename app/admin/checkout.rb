ActiveAdmin.register Checkout , as: "Order" do
  menu priority: 3
  actions :all, :except => [:new]
  config.batch_actions = false
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :email, :phone_number, :shipping_first_name, :shipping_last_name, \
  :shipping_addr1, :shipping_addr2, :shipping_country_id, :shipping_city, :shipping_state_id,\
   :shipping_postal_code, :billing_first_name, :billing_last_name, :billing_addr1, :billing_addr2,\
   :billing_country_id, :billing_city, :billing_state_id, :billing_postal_code, :shipping_method,\
    :payment_option, :card, :month, :year, :cvc, :amount, :same_billing_address, :payed_using, \
    :brand_id,:checkout_status_id,:gallery_visitor_id,:notes_to_studio,:success
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
index do
    # selectable_column
    # id_column
    column "Order",:id
    column "Placed",:created_at
    # column :email_id
    column "First Name", :shipping_first_name
    column "Last Name",:shipping_last_name
    column "Gallery",:gallery_visitor_id do |g|
      g.gallery_visitor.gallery.name
    end
    # column "Order Status",:checkout_status_id do |s|
    #   s.checkout_status.status
    # end
    column :notes_to_studio
    column :studio_internal_notes
    column "Total", :amount
    column "Paid" ,:success do |s|
      if s.success == "t"
        status_tag("Yes")
      else
        status_tag("No")
      end
    end
    # column "Address One",:shipping_addr1
    # column "Address Two",:shipping_addr2
    # column "City",:shipping_city
    # column :shipping_country_id do |c|:amount
    #   c.country.name
    # end
    # column "Pin", :shipping_postal_code
    # column :phone_no
    # column :notes_to_studio
    # column :studio_internal_notes
    # column "Total"
    # column :paid
    # actions
  end
  filter :created_at, label: "Placed"
  filter :shipping_first_name_or_shipping_last_name_cont, label: 'Name'
  filter :gallery_visitor_id, label: "Gallery" ,:as => :select,:collection => proc {(Checkout.all).map{|c| [c.gallery_visitor.gallery.name,c.gallery_visitor.gallery.id]}.uniq}
  filter :success,label: "Paid",:as => :select
  # filter :has_success,label: "Paid",:as => :select
  filter :amount, label: "Total"
end
