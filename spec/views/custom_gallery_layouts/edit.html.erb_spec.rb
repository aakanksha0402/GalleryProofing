require 'rails_helper'

RSpec.describe "custom_gallery_layouts/edit", type: :view do
  before(:each) do
    @custom_gallery_layout = assign(:custom_gallery_layout, CustomGalleryLayout.create!(
      :name => "MyString",
      :introduction_page_layout => "MyString",
      :photo_page_layout => "MyString",
      :status => "MyString",
      :custom_link => "MyString",
      :gallery_access_privacy => "MyString",
      :password => "MyString",
      :email_require => false,
      :cropping => false,
      :preregistration => false,
      :black_and_white_filtering => false,
      :studio_link => "MyString",
      :show_filename => false,
      :social_sharing_link => false,
      :content => "MyString",
      :min_order => 1,
      :add_photo_to_cart => false,
      :pay_later => false,
      :pickup_option => false,
      :checkout_message => "MyString",
      :digital_download => false,
      :entire_gallery_download => false,
      :hide_photos => false,
      :archiving => "MyString",
      :is_default => false,
      :brand => ""
    ))
  end

  it "renders the edit custom_gallery_layout form" do
    render

    assert_select "form[action=?][method=?]", custom_gallery_layout_path(@custom_gallery_layout), "post" do

      assert_select "input#custom_gallery_layout_name[name=?]", "custom_gallery_layout[name]"

      assert_select "input#custom_gallery_layout_introduction_page_layout[name=?]", "custom_gallery_layout[introduction_page_layout]"

      assert_select "input#custom_gallery_layout_photo_page_layout[name=?]", "custom_gallery_layout[photo_page_layout]"

      assert_select "input#custom_gallery_layout_status[name=?]", "custom_gallery_layout[status]"

      assert_select "input#custom_gallery_layout_custom_link[name=?]", "custom_gallery_layout[custom_link]"

      assert_select "input#custom_gallery_layout_gallery_access_privacy[name=?]", "custom_gallery_layout[gallery_access_privacy]"

      assert_select "input#custom_gallery_layout_password[name=?]", "custom_gallery_layout[password]"

      assert_select "input#custom_gallery_layout_email_require[name=?]", "custom_gallery_layout[email_require]"

      assert_select "input#custom_gallery_layout_cropping[name=?]", "custom_gallery_layout[cropping]"

      assert_select "input#custom_gallery_layout_preregistration[name=?]", "custom_gallery_layout[preregistration]"

      assert_select "input#custom_gallery_layout_black_and_white_filtering[name=?]", "custom_gallery_layout[black_and_white_filtering]"

      assert_select "input#custom_gallery_layout_studio_link[name=?]", "custom_gallery_layout[studio_link]"

      assert_select "input#custom_gallery_layout_show_filename[name=?]", "custom_gallery_layout[show_filename]"

      assert_select "input#custom_gallery_layout_social_sharing_link[name=?]", "custom_gallery_layout[social_sharing_link]"

      assert_select "input#custom_gallery_layout_content[name=?]", "custom_gallery_layout[content]"

      assert_select "input#custom_gallery_layout_min_order[name=?]", "custom_gallery_layout[min_order]"

      assert_select "input#custom_gallery_layout_add_photo_to_cart[name=?]", "custom_gallery_layout[add_photo_to_cart]"

      assert_select "input#custom_gallery_layout_pay_later[name=?]", "custom_gallery_layout[pay_later]"

      assert_select "input#custom_gallery_layout_pickup_option[name=?]", "custom_gallery_layout[pickup_option]"

      assert_select "input#custom_gallery_layout_checkout_message[name=?]", "custom_gallery_layout[checkout_message]"

      assert_select "input#custom_gallery_layout_digital_download[name=?]", "custom_gallery_layout[digital_download]"

      assert_select "input#custom_gallery_layout_entire_gallery_download[name=?]", "custom_gallery_layout[entire_gallery_download]"

      assert_select "input#custom_gallery_layout_hide_photos[name=?]", "custom_gallery_layout[hide_photos]"

      assert_select "input#custom_gallery_layout_archiving[name=?]", "custom_gallery_layout[archiving]"

      assert_select "input#custom_gallery_layout_is_default[name=?]", "custom_gallery_layout[is_default]"

      assert_select "input#custom_gallery_layout_brand[name=?]", "custom_gallery_layout[brand]"
    end
  end
end
