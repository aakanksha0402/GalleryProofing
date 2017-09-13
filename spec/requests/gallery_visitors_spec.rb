require 'rails_helper'

RSpec.describe "GalleryVisitors", type: :request do
  describe "GET /gallery_visitors" do
    it "works! (now write some real specs)" do
      get gallery_visitors_path
      expect(response).to have_http_status(200)
    end
  end
end
