require 'rails_helper'

RSpec.describe "Mobileapps", type: :request do
  describe "GET /mobileapps" do
    it "works! (now write some real specs)" do
      get mobileapps_path
      expect(response).to have_http_status(200)
    end
  end
end
