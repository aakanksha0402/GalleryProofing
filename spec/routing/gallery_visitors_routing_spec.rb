require "rails_helper"

RSpec.describe GalleryVisitorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gallery_visitors").to route_to("gallery_visitors#index")
    end

    it "routes to #new" do
      expect(:get => "/gallery_visitors/new").to route_to("gallery_visitors#new")
    end

    it "routes to #show" do
      expect(:get => "/gallery_visitors/1").to route_to("gallery_visitors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gallery_visitors/1/edit").to route_to("gallery_visitors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gallery_visitors").to route_to("gallery_visitors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gallery_visitors/1").to route_to("gallery_visitors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gallery_visitors/1").to route_to("gallery_visitors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gallery_visitors/1").to route_to("gallery_visitors#destroy", :id => "1")
    end

  end
end
