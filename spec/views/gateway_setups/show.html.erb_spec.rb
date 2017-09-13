require 'rails_helper'

RSpec.describe "gateway_setups/show", type: :view do
  before(:each) do
    @gateway_setup = assign(:gateway_setup, GatewaySetup.create!(
      :name => "Name",
      :public_key => "Public Key",
      :private_key => "Private Key",
      :environment => "Environment",
      :merchant_id => "Merchant",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Public Key/)
    expect(rendered).to match(/Private Key/)
    expect(rendered).to match(/Environment/)
    expect(rendered).to match(/Merchant/)
    expect(rendered).to match(//)
  end
end
