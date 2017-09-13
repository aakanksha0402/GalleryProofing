ActiveAdmin.register TransactionSummary, as: "Subscription" do

  menu priority: 5
  actions :all, :except => [:new]
  config.batch_actions = false
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :user_id,:description,:amount,:message,:success,:transaction_id,\
                :last4,:card_type,:created_at,:updated_at,:credit
  #
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
    column "Subscription",:id
    column :description
    # column :email_id
    column "User Name", :user_id do |n|
      "#{n.user.firstname} #{n.user.lastname}"
    end
    column "User email", :user_id do |n|
      n.user.email
    end
    column "Amount Paid",:amount
    column :message
    column :success
    column :transaction_id
    column "Card Last Degit",:last4
    column :card_type
    column "Amount Remains" , :credit
    column :created_at
  end
  filter :description #, label: "ITEM LIST",:as => :select#,:collection => ItemList.all.map{|c| ["#{c.size_one} ✕ #{c.size_two}",c.id]}
  filter :user_id, label: "User Name", :as => :select, :collection => proc {(TransactionSummary.all).map{|t|[t.user.firstname,t.user.id]}.uniq}
  filter :user_id, label: "User Email", :as => :select, :collection => proc {(TransactionSummary.all).map{|t|[t.user.email,t.user.id]}.uniq}
  filter :amount, label: "Amount Paid"
  filter :success
  filter :transaction_id
  filter :card_type, :as => :select
  filter :created_at

end
