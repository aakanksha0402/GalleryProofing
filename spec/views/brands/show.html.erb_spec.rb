require 'rails_helper'

RSpec.describe "brands/show", type: :view do
  before(:each) do
    @brand = assign(:brand, Brand.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Brand Name/)
    expect(rendered).to match(/Website Url/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Address1/)
    expect(rendered).to match(/Address2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Default/)
  end
end
