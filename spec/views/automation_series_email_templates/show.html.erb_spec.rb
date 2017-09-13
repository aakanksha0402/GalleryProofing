require 'rails_helper'

RSpec.describe "automation_series_email_templates/show", type: :view do
  before(:each) do
    @automation_series_email_template = assign(:automation_series_email_template, AutomationSeriesEmailTemplate.create!(
      :automation_series => nil,
      :email_template => nil,
      :default_receipient_type => nil,
      :default_trigger_type => nil,
      :trigger_days => 1,
      :template_name => "Template Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Template Name/)
  end
end
