require 'rails_helper'

RSpec.describe "InvoiceLineItems", type: :request do
  describe "GET /invoice_line_items" do
    it "works! (now write some real specs)" do
      get invoice_line_items_path
      expect(response).to have_http_status(200)
    end
  end
end
