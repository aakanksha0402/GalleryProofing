require 'rails_helper'

RSpec.describe "DefaultReceipientTypes", type: :request do
  describe "GET /default_receipient_types" do
    it "works! (now write some real specs)" do
      get default_receipient_types_path
      expect(response).to have_http_status(200)
    end
  end
end
