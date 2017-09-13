require "rails_helper"

RSpec.describe ClientViewsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/client_views").to route_to("client_views#index")
    end

    it "routes to #new" do
      expect(:get => "/client_views/new").to route_to("client_views#new")
    end

    it "routes to #show" do
      expect(:get => "/client_views/1").to route_to("client_views#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/client_views/1/edit").to route_to("client_views#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/client_views").to route_to("client_views#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/client_views/1").to route_to("client_views#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/client_views/1").to route_to("client_views#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/client_views/1").to route_to("client_views#destroy", :id => "1")
    end

  end
end
