require 'rails_helper'

RSpec.describe "SongLibraries", type: :request do
  describe "GET /song_libraries" do
    it "works! (now write some real specs)" do
      get song_libraries_path
      expect(response).to have_http_status(200)
    end
  end
end
