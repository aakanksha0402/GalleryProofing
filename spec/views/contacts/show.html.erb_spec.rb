require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Buisinessname/)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(/Referredby/)
    expect(rendered).to match(//)
  end
end
