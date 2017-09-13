require "rails_helper"

RSpec.describe MobileappsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mobileapps").to route_to("mobileapps#index")
    end

    it "routes to #new" do
      expect(:get => "/mobileapps/new").to route_to("mobileapps#new")
    end

    it "routes to #show" do
      expect(:get => "/mobileapps/1").to route_to("mobileapps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mobileapps/1/edit").to route_to("mobileapps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mobileapps").to route_to("mobileapps#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mobileapps/1").to route_to("mobileapps#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mobileapps/1").to route_to("mobileapps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mobileapps/1").to route_to("mobileapps#destroy", :id => "1")
    end

  end
end
