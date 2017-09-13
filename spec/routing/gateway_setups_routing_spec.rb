require "rails_helper"

RSpec.describe GatewaySetupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gateway_setups").to route_to("gateway_setups#index")
    end

    it "routes to #new" do
      expect(:get => "/gateway_setups/new").to route_to("gateway_setups#new")
    end

    it "routes to #show" do
      expect(:get => "/gateway_setups/1").to route_to("gateway_setups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gateway_setups/1/edit").to route_to("gateway_setups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gateway_setups").to route_to("gateway_setups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gateway_setups/1").to route_to("gateway_setups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gateway_setups/1").to route_to("gateway_setups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gateway_setups/1").to route_to("gateway_setups#destroy", :id => "1")
    end

  end
end
