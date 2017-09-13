require 'rails_helper'

RSpec.describe "email_templates/new", type: :view do
  before(:each) do
    assign(:email_template, EmailTemplate.new(
      :name => "MyString",
      :email_subject => "MyString",
      :headline => "MyString",
      :button_text => "MyString",
      :email_body => "MyString",
      :default_email_template => nil,
      :brand => nil
    ))
  end

  it "renders new email_template form" do
    render

    assert_select "form[action=?][method=?]", email_templates_path, "post" do

      assert_select "input#email_template_name[name=?]", "email_template[name]"

      assert_select "input#email_template_email_subject[name=?]", "email_template[email_subject]"

      assert_select "input#email_template_headline[name=?]", "email_template[headline]"

      assert_select "input#email_template_button_text[name=?]", "email_template[button_text]"

      assert_select "input#email_template_email_body[name=?]", "email_template[email_body]"

      assert_select "input#email_template_default_email_template_id[name=?]", "email_template[default_email_template_id]"

      assert_select "input#email_template_brand_id[name=?]", "email_template[brand_id]"
    end
  end
end
