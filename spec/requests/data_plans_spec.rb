require 'rails_helper'

RSpec.describe "DataPlans", type: :request do
  describe "GET /data_plans" do
    it "works! (now write some real specs)" do
      get data_plans_path
      expect(response).to have_http_status(200)
    end
  end
end
