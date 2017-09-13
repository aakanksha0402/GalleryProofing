require 'rails_helper'

RSpec.describe "mobileapps/new", type: :view do
  before(:each) do
    assign(:mobileapp, Mobileapp.new(
      :name => "MyString",
      :contact_info => false,
      :social_sharing => false,
      :layout => false,
      :language => "MyString",
      :mobileapp_photo => nil,
      :color_logo => nil,
      :mobileapp_custom_link => nil,
      :gallery => nil
    ))
  end

  it "renders new mobileapp form" do
    render

    assert_select "form[action=?][method=?]", mobileapps_path, "post" do

      assert_select "input#mobileapp_name[name=?]", "mobileapp[name]"

      assert_select "input#mobileapp_contact_info[name=?]", "mobileapp[contact_info]"

      assert_select "input#mobileapp_social_sharing[name=?]", "mobileapp[social_sharing]"

      assert_select "input#mobileapp_layout[name=?]", "mobileapp[layout]"

      assert_select "input#mobileapp_language[name=?]", "mobileapp[language]"

      assert_select "input#mobileapp_mobileapp_photo_id[name=?]", "mobileapp[mobileapp_photo_id]"

      assert_select "input#mobileapp_color_logo_id[name=?]", "mobileapp[color_logo_id]"

      assert_select "input#mobileapp_mobileapp_custom_link_id[name=?]", "mobileapp[mobileapp_custom_link_id]"

      assert_select "input#mobileapp_gallery_id[name=?]", "mobileapp[gallery_id]"
    end
  end
end
