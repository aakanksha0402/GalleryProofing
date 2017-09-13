require 'rails_helper'

RSpec.describe "invoice_line_items/new", type: :view do
  before(:each) do
    assign(:invoice_line_item, InvoiceLineItem.new())
  end

  it "renders new invoice_line_item form" do
    render

    assert_select "form[action=?][method=?]", invoice_line_items_path, "post" do
    end
  end
end
