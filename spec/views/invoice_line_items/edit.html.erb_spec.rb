require 'rails_helper'

RSpec.describe "invoice_line_items/edit", type: :view do
  before(:each) do
    @invoice_line_item = assign(:invoice_line_item, InvoiceLineItem.create!())
  end

  it "renders the edit invoice_line_item form" do
    render

    assert_select "form[action=?][method=?]", invoice_line_item_path(@invoice_line_item), "post" do
    end
  end
end
