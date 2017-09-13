require "rails_helper"

RSpec.describe GalleryLayoutsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gallery_layouts").to route_to("gallery_layouts#index")
    end

    it "routes to #new" do
      expect(:get => "/gallery_layouts/new").to route_to("gallery_layouts#new")
    end

    it "routes to #show" do
      expect(:get => "/gallery_layouts/1").to route_to("gallery_layouts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gallery_layouts/1/edit").to route_to("gallery_layouts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gallery_layouts").to route_to("gallery_layouts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gallery_layouts/1").to route_to("gallery_layouts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gallery_layouts/1").to route_to("gallery_layouts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gallery_layouts/1").to route_to("gallery_layouts#destroy", :id => "1")
    end

  end
end
