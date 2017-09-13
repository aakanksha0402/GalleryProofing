require 'rails_helper'

RSpec.describe "default_email_template_types/new", type: :view do
  before(:each) do
    assign(:default_email_template_type, DefaultEmailTemplateType.new(
      :name => "MyString"
    ))
  end

  it "renders new default_email_template_type form" do
    render

    assert_select "form[action=?][method=?]", default_email_template_types_path, "post" do

      assert_select "input#default_email_template_type_name[name=?]", "default_email_template_type[name]"
    end
  end
end
