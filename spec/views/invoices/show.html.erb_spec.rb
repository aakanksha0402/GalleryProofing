require 'rails_helper'

RSpec.describe "invoices/show", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Sales Label/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
  end
end
