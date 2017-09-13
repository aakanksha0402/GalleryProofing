require 'rails_helper'

RSpec.describe "GalleryLayouts", type: :request do
  describe "GET /gallery_layouts" do
    it "works! (now write some real specs)" do
      get gallery_layouts_path
      expect(response).to have_http_status(200)
    end
  end
end
