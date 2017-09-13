require 'rails_helper'

RSpec.describe "ClientViews", type: :request do
  describe "GET /client_views" do
    it "works! (now write some real specs)" do
      get client_views_path
      expect(response).to have_http_status(200)
    end
  end
end
