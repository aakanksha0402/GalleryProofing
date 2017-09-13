require 'rails_helper'

RSpec.describe "gateway_setups/new", type: :view do
  before(:each) do
    assign(:gateway_setup, GatewaySetup.new(
      :name => "MyString",
      :public_key => "MyString",
      :private_key => "MyString",
      :environment => "MyString",
      :merchant_id => "MyString",
      :user => nil
    ))
  end

  it "renders new gateway_setup form" do
    render

    assert_select "form[action=?][method=?]", gateway_setups_path, "post" do

      assert_select "input#gateway_setup_name[name=?]", "gateway_setup[name]"

      assert_select "input#gateway_setup_public_key[name=?]", "gateway_setup[public_key]"

      assert_select "input#gateway_setup_private_key[name=?]", "gateway_setup[private_key]"

      assert_select "input#gateway_setup_environment[name=?]", "gateway_setup[environment]"

      assert_select "input#gateway_setup_merchant_id[name=?]", "gateway_setup[merchant_id]"

      assert_select "input#gateway_setup_user_id[name=?]", "gateway_setup[user_id]"
    end
  end
end
