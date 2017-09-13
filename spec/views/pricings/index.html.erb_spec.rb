require 'rails_helper'

RSpec.describe "pricings/index", type: :view do
  before(:each) do
    assign(:pricings, [
      Pricing.create!(
        :name => "Name",
        :is_deleted => false,
        :user => nil,
        :pricing_style => nil
      ),
      Pricing.create!(
        :name => "Name",
        :is_deleted => false,
        :user => nil,
        :pricing_style => nil
      )
    ])
  end

  it "renders a list of pricings" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
