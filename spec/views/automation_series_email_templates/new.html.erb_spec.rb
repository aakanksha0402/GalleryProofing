require 'rails_helper'

RSpec.describe "automation_series_email_templates/new", type: :view do
  before(:each) do
    assign(:automation_series_email_template, AutomationSeriesEmailTemplate.new(
      :automation_series => nil,
      :email_template => nil,
      :default_receipient_type => nil,
      :default_trigger_type => nil,
      :trigger_days => 1,
      :template_name => "MyString"
    ))
  end

  it "renders new automation_series_email_template form" do
    render

    assert_select "form[action=?][method=?]", automation_series_email_templates_path, "post" do

      assert_select "input#automation_series_email_template_automation_series_id[name=?]", "automation_series_email_template[automation_series_id]"

      assert_select "input#automation_series_email_template_email_template_id[name=?]", "automation_series_email_template[email_template_id]"

      assert_select "input#automation_series_email_template_default_receipient_type_id[name=?]", "automation_series_email_template[default_receipient_type_id]"

      assert_select "input#automation_series_email_template_default_trigger_type_id[name=?]", "automation_series_email_template[default_trigger_type_id]"

      assert_select "input#automation_series_email_template_trigger_days[name=?]", "automation_series_email_template[trigger_days]"

      assert_select "input#automation_series_email_template_template_name[name=?]", "automation_series_email_template[template_name]"
    end
  end
end
