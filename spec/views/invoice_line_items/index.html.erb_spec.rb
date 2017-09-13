require 'rails_helper'

RSpec.describe "invoice_line_items/index", type: :view do
  before(:each) do
    assign(:invoice_line_items, [
      InvoiceLineItem.create!(),
      InvoiceLineItem.create!()
    ])
  end

  it "renders a list of invoice_line_items" do
    render
  end
end
