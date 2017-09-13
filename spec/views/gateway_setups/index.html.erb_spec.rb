require 'rails_helper'

RSpec.describe "gateway_setups/index", type: :view do
  before(:each) do
    assign(:gateway_setups, [
      GatewaySetup.create!(
        :name => "Name",
        :public_key => "Public Key",
        :private_key => "Private Key",
        :environment => "Environment",
        :merchant_id => "Merchant",
        :user => nil
      ),
      GatewaySetup.create!(
        :name => "Name",
        :public_key => "Public Key",
        :private_key => "Private Key",
        :environment => "Environment",
        :merchant_id => "Merchant",
        :user => nil
      )
    ])
  end

  it "renders a list of gateway_setups" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Public Key".to_s, :count => 2
    assert_select "tr>td", :text => "Private Key".to_s, :count => 2
    assert_select "tr>td", :text => "Environment".to_s, :count => 2
    assert_select "tr>td", :text => "Merchant".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
