require 'rails_helper'

RSpec.describe "default_email_template_types/index", type: :view do
  before(:each) do
    assign(:default_email_template_types, [
      DefaultEmailTemplateType.create!(
        :name => "Name"
      ),
      DefaultEmailTemplateType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of default_email_template_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
