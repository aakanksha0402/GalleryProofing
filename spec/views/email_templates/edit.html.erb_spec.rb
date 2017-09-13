require 'rails_helper'

RSpec.describe "email_templates/edit", type: :view do
  before(:each) do
    @email_template = assign(:email_template, EmailTemplate.create!(
      :name => "MyString",
      :email_subject => "MyString",
      :headline => "MyString",
      :button_text => "MyString",
      :email_body => "MyString",
      :default_email_template => nil,
      :brand => nil
    ))
  end

  it "renders the edit email_template form" do
    render

    assert_select "form[action=?][method=?]", email_template_path(@email_template), "post" do

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
