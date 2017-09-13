require 'rails_helper'

RSpec.describe "email_templates/index", type: :view do
  before(:each) do
    assign(:email_templates, [
      EmailTemplate.create!(
        :name => "Name",
        :email_subject => "Email Subject",
        :headline => "Headline",
        :button_text => "Button Text",
        :email_body => "Email Body",
        :default_email_template => nil,
        :brand => nil
      ),
      EmailTemplate.create!(
        :name => "Name",
        :email_subject => "Email Subject",
        :headline => "Headline",
        :button_text => "Button Text",
        :email_body => "Email Body",
        :default_email_template => nil,
        :brand => nil
      )
    ])
  end

  it "renders a list of email_templates" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Headline".to_s, :count => 2
    assert_select "tr>td", :text => "Button Text".to_s, :count => 2
    assert_select "tr>td", :text => "Email Body".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
