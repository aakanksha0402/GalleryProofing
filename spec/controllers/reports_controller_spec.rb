require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #gallery_visitors" do
    it "returns http success" do
      get :gallery_visitors
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #sales" do
    it "returns http success" do
      get :sales
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #orders" do
    it "returns http success" do
      get :orders
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #ordered_files" do
    it "returns http success" do
      get :ordered_files
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #items" do
    it "returns http success" do
      get :items
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #invoice_payments" do
    it "returns http success" do
      get :invoice_payments
      expect(response).to have_http_status(:success)
    end
  end

end
