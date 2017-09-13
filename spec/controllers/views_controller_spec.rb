require 'rails_helper'

RSpec.describe ViewsController, type: :controller do

  describe "GET #view_home_page" do
    it "returns http success" do
      get :view_home_page
      expect(response).to have_http_status(:success)
    end
  end

end
