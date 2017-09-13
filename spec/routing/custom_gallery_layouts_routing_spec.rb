require "rails_helper"

RSpec.describe CustomGalleryLayoutsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/custom_gallery_layouts").to route_to("custom_gallery_layouts#index")
    end

    it "routes to #new" do
      expect(:get => "/custom_gallery_layouts/new").to route_to("custom_gallery_layouts#new")
    end

    it "routes to #show" do
      expect(:get => "/custom_gallery_layouts/1").to route_to("custom_gallery_layouts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/custom_gallery_layouts/1/edit").to route_to("custom_gallery_layouts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/custom_gallery_layouts").to route_to("custom_gallery_layouts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/custom_gallery_layouts/1").to route_to("custom_gallery_layouts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/custom_gallery_layouts/1").to route_to("custom_gallery_layouts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/custom_gallery_layouts/1").to route_to("custom_gallery_layouts#destroy", :id => "1")
    end

  end
end
