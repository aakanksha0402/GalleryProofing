require "rails_helper"

RSpec.describe StudioHomePagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/studio_home_pages").to route_to("studio_home_pages#index")
    end

    it "routes to #new" do
      expect(:get => "/studio_home_pages/new").to route_to("studio_home_pages#new")
    end

    it "routes to #show" do
      expect(:get => "/studio_home_pages/1").to route_to("studio_home_pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/studio_home_pages/1/edit").to route_to("studio_home_pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/studio_home_pages").to route_to("studio_home_pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/studio_home_pages/1").to route_to("studio_home_pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/studio_home_pages/1").to route_to("studio_home_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/studio_home_pages/1").to route_to("studio_home_pages#destroy", :id => "1")
    end

  end
end
