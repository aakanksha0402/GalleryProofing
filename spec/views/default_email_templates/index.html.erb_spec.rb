require 'rails_helper'

RSpec.describe "default_email_templates/index", type: :view do
  before(:each) do
    assign(:default_email_templates, [
      DefaultEmailTemplate.create!(
        :email_type => "Email Type",
        :email_subject => "Email Subject",
        :headline => "Headline",
        :button_text => "Button Text",
        :email_body => "Email Body"
      ),
      DefaultEmailTemplate.create!(
        :email_type => "Email Type",
        :email_subject => "Email Subject",
        :headline => "Headline",
        :button_text => "Button Text",
        :email_body => "Email Body"
      )
    ])
  end

  it "renders a list of default_email_templates" do
    render
    assert_select "tr>td", :text => "Email Type".to_s, :count => 2
    assert_select "tr>td", :text => "Email Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Headline".to_s, :count => 2
    assert_select "tr>td", :text => "Button Text".to_s, :count => 2
    assert_select "tr>td", :text => "Email Body".to_s, :count => 2
  end
end
