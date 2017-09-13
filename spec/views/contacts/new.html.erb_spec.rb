require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  before(:each) do
    assign(:contact, Contact.new(
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString",
      :address => "MyString",
      :city => "MyString",
      :country => "MyString",
      :pincode => 1,
      :phone_number => 1,
      :vendor => false,
      :buisinessname => "MyString",
      :tags => "MyString",
      :referredby => "MyString",
      :user => nil
    ))
  end

  it "renders new contact form" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do

      assert_select "input#contact_firstname[name=?]", "contact[firstname]"

      assert_select "input#contact_lastname[name=?]", "contact[lastname]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_address[name=?]", "contact[address]"

      assert_select "input#contact_city[name=?]", "contact[city]"

      assert_select "input#contact_country[name=?]", "contact[country]"

      assert_select "input#contact_pincode[name=?]", "contact[pincode]"

      assert_select "input#contact_phone_number[name=?]", "contact[phone_number]"

      assert_select "input#contact_vendor[name=?]", "contact[vendor]"

      assert_select "input#contact_buisinessname[name=?]", "contact[buisinessname]"

      assert_select "input#contact_tags[name=?]", "contact[tags]"

      assert_select "input#contact_referredby[name=?]", "contact[referredby]"

      assert_select "input#contact_user_id[name=?]", "contact[user_id]"
    end
  end
end
