require 'rails_helper'

RSpec.describe PlansBillingsController, type: :controller do

  describe "GET #planbilling" do
    it "returns http success" do
      get :planbilling
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #changeplan" do
    it "returns http success" do
      get :changeplan
      expect(response).to have_http_status(:success)
    end
  end

end
