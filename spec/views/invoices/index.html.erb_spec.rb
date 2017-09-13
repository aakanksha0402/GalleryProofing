require 'rails_helper'

RSpec.describe "invoices/index", type: :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        :brand => nil,
        :client_contact => nil,
        :automation_series => nil,
        :color_logo => nil,
        :sales_label => "Sales Label",
        :sales_rate => "9.99",
        :notes_to_client => "MyText",
        :discount_type => nil,
        :deposit_amount => "9.99",
        :allow_payment_cash_cheque => false,
        :allow_payment_credit_card => false,
        :payment_confirmation_text => "MyText"
      ),
      Invoice.create!(
        :brand => nil,
        :client_contact => nil,
        :automation_series => nil,
        :color_logo => nil,
        :sales_label => "Sales Label",
        :sales_rate => "9.99",
        :notes_to_client => "MyText",
        :discount_type => nil,
        :deposit_amount => "9.99",
        :allow_payment_cash_cheque => false,
        :allow_payment_credit_card => false,
        :payment_confirmation_text => "MyText"
      )
    ])
  end

  it "renders a list of invoices" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Sales Label".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
