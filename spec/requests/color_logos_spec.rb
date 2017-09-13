require 'rails_helper'

RSpec.describe "ColorLogos", type: :request do
  describe "GET /color_logos" do
    it "works! (now write some real specs)" do
      get color_logos_path
      expect(response).to have_http_status(200)
    end
  end
end
