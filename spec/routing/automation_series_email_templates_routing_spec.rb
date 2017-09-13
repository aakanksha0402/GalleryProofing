require "rails_helper"

RSpec.describe AutomationSeriesEmailTemplatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/automation_series_email_templates").to route_to("automation_series_email_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/automation_series_email_templates/new").to route_to("automation_series_email_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/automation_series_email_templates/1").to route_to("automation_series_email_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/automation_series_email_templates/1/edit").to route_to("automation_series_email_templates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/automation_series_email_templates").to route_to("automation_series_email_templates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/automation_series_email_templates/1").to route_to("automation_series_email_templates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/automation_series_email_templates/1").to route_to("automation_series_email_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/automation_series_email_templates/1").to route_to("automation_series_email_templates#destroy", :id => "1")
    end

  end
end
