require 'rails_helper'

RSpec.describe "StudioHomePages", type: :request do
  describe "GET /studio_home_pages" do
    it "works! (now write some real specs)" do
      get studio_home_pages_path
      expect(response).to have_http_status(200)
    end
  end
end
