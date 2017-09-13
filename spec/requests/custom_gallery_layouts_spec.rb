require 'rails_helper'

RSpec.describe "CustomGalleryLayouts", type: :request do
  describe "GET /custom_gallery_layouts" do
    it "works! (now write some real specs)" do
      get custom_gallery_layouts_path
      expect(response).to have_http_status(200)
    end
  end
end
