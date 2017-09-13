require 'rails_helper'

RSpec.describe "brands/edit", type: :view do
  before(:each) do
    @brand = assign(:brand, Brand.create!(
      :user => nil,
      :brand_name => "MyString",
      :website_url => "MyString",
      :email => "MyString",
      :address1 => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :country => "MyString",
      :pincode => 1,
      :phone_number => 1,
      :default => "MyString"
    ))
  end

  it "renders the edit brand form" do
    render

    assert_select "form[action=?][method=?]", brand_path(@brand), "post" do

      assert_select "input#brand_user_id[name=?]", "brand[user_id]"

      assert_select "input#brand_brand_name[name=?]", "brand[brand_name]"

      assert_select "input#brand_website_url[name=?]", "brand[website_url]"

      assert_select "input#brand_email[name=?]", "brand[email]"

      assert_select "input#brand_address1[name=?]", "brand[address1]"

      assert_select "input#brand_address2[name=?]", "brand[address2]"

      assert_select "input#brand_city[name=?]", "brand[city]"

      assert_select "input#brand_country[name=?]", "brand[country]"

      assert_select "input#brand_pincode[name=?]", "brand[pincode]"

      assert_select "input#brand_phone_number[name=?]", "brand[phone_number]"

      assert_select "input#brand_default[name=?]", "brand[default]"
    end
  end
end
