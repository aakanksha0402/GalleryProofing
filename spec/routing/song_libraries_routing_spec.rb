require "rails_helper"

RSpec.describe SongLibrariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/song_libraries").to route_to("song_libraries#index")
    end

    it "routes to #new" do
      expect(:get => "/song_libraries/new").to route_to("song_libraries#new")
    end

    it "routes to #show" do
      expect(:get => "/song_libraries/1").to route_to("song_libraries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/song_libraries/1/edit").to route_to("song_libraries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/song_libraries").to route_to("song_libraries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/song_libraries/1").to route_to("song_libraries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/song_libraries/1").to route_to("song_libraries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/song_libraries/1").to route_to("song_libraries#destroy", :id => "1")
    end

  end
end
