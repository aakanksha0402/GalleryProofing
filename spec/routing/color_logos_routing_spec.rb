require "rails_helper"

RSpec.describe ColorLogosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/color_logos").to route_to("color_logos#index")
    end

    it "routes to #new" do
      expect(:get => "/color_logos/new").to route_to("color_logos#new")
    end

    it "routes to #show" do
      expect(:get => "/color_logos/1").to route_to("color_logos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/color_logos/1/edit").to route_to("color_logos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/color_logos").to route_to("color_logos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/color_logos/1").to route_to("color_logos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/color_logos/1").to route_to("color_logos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/color_logos/1").to route_to("color_logos#destroy", :id => "1")
    end

  end
end
