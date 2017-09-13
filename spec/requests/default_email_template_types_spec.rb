require 'rails_helper'

RSpec.describe "DefaultEmailTemplateTypes", type: :request do
  describe "GET /default_email_template_types" do
    it "works! (now write some real specs)" do
      get default_email_template_types_path
      expect(response).to have_http_status(200)
    end
  end
end
