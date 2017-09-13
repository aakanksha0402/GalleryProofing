require 'rails_helper'

RSpec.describe "gallery_layouts/index", type: :view do
  before(:each) do
    assign(:gallery_layouts, [
      GalleryLayout.create!(
        :name => "Name",
        :introduction_page_layout => "Introduction Page Layout",
        :photo_page_layout => "Photo Page Layout",
        :status => "Status",
        :custom_link => "Custom Link",
        :gallery_access_privacy => "Gallery Access Privacy",
        :password => "Password",
        :email_require => false,
        :cropping => false,
        :preregistration => false,
        :black_and_white_filtering => false,
        :studio_link => "Studio Link",
        :show_filename => false,
        :social_sharing_link => false,
        :content => "Content",
        :min_order => 1,
        :add_photo_to_cart => false,
        :pay_later => false,
        :pickup_option => false,
        :checkout_message => "Checkout Message",
        :digital_download => false,
        :entire_gallery_download => false,
        :hide_photos => false,
        :archiving => "Archiving",
        :is_default => false
      ),
      GalleryLayout.create!(
        :name => "Name",
        :introduction_page_layout => "Introduction Page Layout",
        :photo_page_layout => "Photo Page Layout",
        :status => "Status",
        :custom_link => "Custom Link",
        :gallery_access_privacy => "Gallery Access Privacy",
        :password => "Password",
        :email_require => false,
        :cropping => false,
        :preregistration => false,
        :black_and_white_filtering => false,
        :studio_link => "Studio Link",
        :show_filename => false,
        :social_sharing_link => false,
        :content => "Content",
        :min_order => 1,
        :add_photo_to_cart => false,
        :pay_later => false,
        :pickup_option => false,
        :checkout_message => "Checkout Message",
        :digital_download => false,
        :entire_gallery_download => false,
        :hide_photos => false,
        :archiving => "Archiving",
        :is_default => false
      )
    ])
  end

  it "renders a list of gallery_layouts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Introduction Page Layout".to_s, :count => 2
    assert_select "tr>td", :text => "Photo Page Layout".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Custom Link".to_s, :count => 2
    assert_select "tr>td", :text => "Gallery Access Privacy".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Studio Link".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Checkout Message".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Archiving".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
