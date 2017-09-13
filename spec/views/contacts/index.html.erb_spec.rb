require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email",
        :address => "Address",
        :city => "City",
        :country => "Country",
        :pincode => 1,
        :phone_number => 2,
        :vendor => false,
        :buisinessname => "Buisinessname",
        :tags => "Tags",
        :referredby => "Referredby",
        :user => nil
      ),
      Contact.create!(
        :firstname => "Firstname",
        :lastname => "Lastname",
        :email => "Email",
        :address => "Address",
        :city => "City",
        :country => "Country",
        :pincode => 1,
        :phone_number => 2,
        :vendor => false,
        :buisinessname => "Buisinessname",
        :tags => "Tags",
        :referredby => "Referredby",
        :user => nil
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Buisinessname".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Referredby".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
