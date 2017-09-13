require 'rails_helper'

RSpec.describe "invoice_line_items/show", type: :view do
  before(:each) do
    @invoice_line_item = assign(:invoice_line_item, InvoiceLineItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
