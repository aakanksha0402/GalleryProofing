require 'rails_helper'

RSpec.describe "default_email_templates/new", type: :view do
  before(:each) do
    assign(:default_email_template, DefaultEmailTemplate.new(
      :email_type => "MyString",
      :email_subject => "MyString",
      :headline => "MyString",
      :button_text => "MyString",
      :email_body => "MyString"
    ))
  end

  it "renders new default_email_template form" do
    render

    assert_select "form[action=?][method=?]", default_email_templates_path, "post" do

      assert_select "input#default_email_template_email_type[name=?]", "default_email_template[email_type]"

      assert_select "input#default_email_template_email_subject[name=?]", "default_email_template[email_subject]"

      assert_select "input#default_email_template_headline[name=?]", "default_email_template[headline]"

      assert_select "input#default_email_template_button_text[name=?]", "default_email_template[button_text]"

      assert_select "input#default_email_template_email_body[name=?]", "default_email_template[email_body]"
    end
  end
end
