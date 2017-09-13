require 'rails_helper'

RSpec.describe "AutomationSeriesEmailTemplates", type: :request do
  describe "GET /automation_series_email_templates" do
    it "works! (now write some real specs)" do
      get automation_series_email_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
