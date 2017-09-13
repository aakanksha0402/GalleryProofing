require 'rails_helper'

RSpec.describe "brands/index", type: :view do
  before(:each) do
    assign(:brands, [
      Brand.create!(
        :user => nil,
        :brand_name => "Brand Name",
        :website_url => "Website Url",
        :email => "Email",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :country => "Country",
        :pincode => 1,
        :phone_number => 2,
        :default => "Default"
      ),
      Brand.create!(
        :user => nil,
        :brand_name => "Brand Name",
        :website_url => "Website Url",
        :email => "Email",
        :address1 => "Address1",
        :address2 => "Address2",
        :city => "City",
        :country => "Country",
        :pincode => 1,
        :phone_number => 2,
        :default => "Default"
      )
    ])
  end

  it "renders a list of brands" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Brand Name".to_s, :count => 2
    assert_select "tr>td", :text => "Website Url".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Default".to_s, :count => 2
  end
end
