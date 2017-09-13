require 'rails_helper'

RSpec.describe "pricings/show", type: :view do
  before(:each) do
    @pricing = assign(:pricing, Pricing.create!(
      :name => "Name",
      :is_deleted => false,
      :user => nil,
      :pricing_style => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
