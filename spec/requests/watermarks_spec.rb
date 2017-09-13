require 'rails_helper'

RSpec.describe "Watermarks", type: :request do
  describe "GET /watermarks" do
    it "works! (now write some real specs)" do
      get watermarks_path
      expect(response).to have_http_status(200)
    end
  end
end
