require 'rails_helper'

RSpec.describe "email_templates/show", type: :view do
  before(:each) do
    @email_template = assign(:email_template, EmailTemplate.create!(
      :name => "Name",
      :email_subject => "Email Subject",
      :headline => "Headline",
      :button_text => "Button Text",
      :email_body => "Email Body",
      :default_email_template => nil,
      :brand => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email Subject/)
    expect(rendered).to match(/Headline/)
    expect(rendered).to match(/Button Text/)
    expect(rendered).to match(/Email Body/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
