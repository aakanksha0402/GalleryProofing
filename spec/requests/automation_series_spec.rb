require 'rails_helper'

RSpec.describe "AutomationSeries", type: :request do
  describe "GET /automation_series" do
    it "works! (now write some real specs)" do
      get automation_series_index_path
      expect(response).to have_http_status(200)
    end
  end
end
