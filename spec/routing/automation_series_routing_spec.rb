require "rails_helper"

RSpec.describe AutomationSeriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/automation_series").to route_to("automation_series#index")
    end

    it "routes to #new" do
      expect(:get => "/automation_series/new").to route_to("automation_series#new")
    end

    it "routes to #show" do
      expect(:get => "/automation_series/1").to route_to("automation_series#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/automation_series/1/edit").to route_to("automation_series#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/automation_series").to route_to("automation_series#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/automation_series/1").to route_to("automation_series#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/automation_series/1").to route_to("automation_series#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/automation_series/1").to route_to("automation_series#destroy", :id => "1")
    end

  end
end
