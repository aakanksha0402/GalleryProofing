require "rails_helper"

RSpec.describe DefaultEmailTemplateTypesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/default_email_template_types").to route_to("default_email_template_types#index")
    end

    it "routes to #new" do
      expect(:get => "/default_email_template_types/new").to route_to("default_email_template_types#new")
    end

    it "routes to #show" do
      expect(:get => "/default_email_template_types/1").to route_to("default_email_template_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/default_email_template_types/1/edit").to route_to("default_email_template_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/default_email_template_types").to route_to("default_email_template_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/default_email_template_types/1").to route_to("default_email_template_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/default_email_template_types/1").to route_to("default_email_template_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/default_email_template_types/1").to route_to("default_email_template_types#destroy", :id => "1")
    end

  end
end
