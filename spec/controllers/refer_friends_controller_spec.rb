require 'rails_helper'

RSpec.describe ReferFriendsController, type: :controller do

  describe "GET #refer" do
    it "returns http success" do
      get :refer
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #send_email" do
    it "returns http success" do
      get :send_email
      expect(response).to have_http_status(:success)
    end
  end

end
