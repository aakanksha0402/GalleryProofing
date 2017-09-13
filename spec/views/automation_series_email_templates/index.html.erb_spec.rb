require 'rails_helper'

RSpec.describe "automation_series_email_templates/index", type: :view do
  before(:each) do
    assign(:automation_series_email_templates, [
      AutomationSeriesEmailTemplate.create!(
        :automation_series => nil,
        :email_template => nil,
        :default_receipient_type => nil,
        :default_trigger_type => nil,
        :trigger_days => 1,
        :template_name => "Template Name"
      ),
      AutomationSeriesEmailTemplate.create!(
        :automation_series => nil,
        :email_template => nil,
        :default_receipient_type => nil,
        :default_trigger_type => nil,
        :trigger_days => 1,
        :template_name => "Template Name"
      )
    ])
  end

  it "renders a list of automation_series_email_templates" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Template Name".to_s, :count => 2
  end
end
