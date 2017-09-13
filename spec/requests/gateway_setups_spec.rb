require 'rails_helper'

RSpec.describe "GatewaySetups", type: :request do
  describe "GET /gateway_setups" do
    it "works! (now write some real specs)" do
      get gateway_setups_path
      expect(response).to have_http_status(200)
    end
  end
end
