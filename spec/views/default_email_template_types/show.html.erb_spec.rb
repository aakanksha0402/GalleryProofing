require 'rails_helper'

RSpec.describe "default_email_template_types/show", type: :view do
  before(:each) do
    @default_email_template_type = assign(:default_email_template_type, DefaultEmailTemplateType.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
