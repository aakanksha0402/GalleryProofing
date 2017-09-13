require 'rails_helper'

RSpec.describe "MusicCategories", type: :request do
  describe "GET /music_categories" do
    it "works! (now write some real specs)" do
      get music_categories_path
      expect(response).to have_http_status(200)
    end
  end
end
