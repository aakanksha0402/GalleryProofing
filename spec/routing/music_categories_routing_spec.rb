require "rails_helper"

RSpec.describe MusicCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/music_categories").to route_to("music_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/music_categories/new").to route_to("music_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/music_categories/1").to route_to("music_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/music_categories/1/edit").to route_to("music_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/music_categories").to route_to("music_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/music_categories/1").to route_to("music_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/music_categories/1").to route_to("music_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/music_categories/1").to route_to("music_categories#destroy", :id => "1")
    end

  end
end
