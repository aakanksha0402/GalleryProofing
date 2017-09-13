require "rails_helper"

RSpec.describe WatermarksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/watermarks").to route_to("watermarks#index")
    end

    it "routes to #new" do
      expect(:get => "/watermarks/new").to route_to("watermarks#new")
    end

    it "routes to #show" do
      expect(:get => "/watermarks/1").to route_to("watermarks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/watermarks/1/edit").to route_to("watermarks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/watermarks").to route_to("watermarks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/watermarks/1").to route_to("watermarks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/watermarks/1").to route_to("watermarks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/watermarks/1").to route_to("watermarks#destroy", :id => "1")
    end

  end
end
