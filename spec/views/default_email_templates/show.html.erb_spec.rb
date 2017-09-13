require 'rails_helper'

RSpec.describe "default_email_templates/show", type: :view do
  before(:each) do
    @default_email_template = assign(:default_email_template, DefaultEmailTemplate.create!(
      :email_type => "Email Type",
      :email_subject => "Email Subject",
      :headline => "Headline",
      :button_text => "Button Text",
      :email_body => "Email Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email Type/)
    expect(rendered).to match(/Email Subject/)
    expect(rendered).to match(/Headline/)
    expect(rendered).to match(/Button Text/)
    expect(rendered).to match(/Email Body/)
  end
end
