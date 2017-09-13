require 'rails_helper'

RSpec.describe "DefaultTriggerTypes", type: :request do
  describe "GET /default_trigger_types" do
    it "works! (now write some real specs)" do
      get default_trigger_types_path
      expect(response).to have_http_status(200)
    end
  end
end
