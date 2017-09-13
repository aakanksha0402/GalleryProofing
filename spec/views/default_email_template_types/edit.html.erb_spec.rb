require 'rails_helper'

RSpec.describe "default_email_template_types/edit", type: :view do
  before(:each) do
    @default_email_template_type = assign(:default_email_template_type, DefaultEmailTemplateType.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit default_email_template_type form" do
    render

    assert_select "form[action=?][method=?]", default_email_template_type_path(@default_email_template_type), "post" do

      assert_select "input#default_email_template_type_name[name=?]", "default_email_template_type[name]"
    end
  end
end
