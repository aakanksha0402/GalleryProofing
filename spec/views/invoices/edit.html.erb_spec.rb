require 'rails_helper'

RSpec.describe "invoices/edit", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      :brand => nil,
      :client_contact => nil,
      :automation_series => nil,
      :color_logo => nil,
      :sales_label => "MyString",
      :sales_rate => "9.99",
      :notes_to_client => "MyText",
      :discount_type => nil,
      :deposit_amount => "9.99",
      :allow_payment_cash_cheque => false,
      :allow_payment_credit_card => false,
      :payment_confirmation_text => "MyText"
    ))
  end

  it "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(@invoice), "post" do

      assert_select "input#invoice_brand_id[name=?]", "invoice[brand_id]"

      assert_select "input#invoice_client_contact_id[name=?]", "invoice[client_contact_id]"

      assert_select "input#invoice_automation_series_id[name=?]", "invoice[automation_series_id]"

      assert_select "input#invoice_color_logo_id[name=?]", "invoice[color_logo_id]"

      assert_select "input#invoice_sales_label[name=?]", "invoice[sales_label]"

      assert_select "input#invoice_sales_rate[name=?]", "invoice[sales_rate]"

      assert_select "textarea#invoice_notes_to_client[name=?]", "invoice[notes_to_client]"

      assert_select "input#invoice_discount_type_id[name=?]", "invoice[discount_type_id]"

      assert_select "input#invoice_deposit_amount[name=?]", "invoice[deposit_amount]"

      assert_select "input#invoice_allow_payment_cash_cheque[name=?]", "invoice[allow_payment_cash_cheque]"

      assert_select "input#invoice_allow_payment_credit_card[name=?]", "invoice[allow_payment_credit_card]"

      assert_select "textarea#invoice_payment_confirmation_text[name=?]", "invoice[payment_confirmation_text]"
    end
  end
end
