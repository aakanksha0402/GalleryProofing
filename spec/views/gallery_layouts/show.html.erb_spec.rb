require 'rails_helper'

RSpec.describe "gallery_layouts/show", type: :view do
  before(:each) do
    @gallery_layout = assign(:gallery_layout, GalleryLayout.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Introduction Page Layout/)
    expect(rendered).to match(/Photo Page Layout/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Custom Link/)
    expect(rendered).to match(/Gallery Access Privacy/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Studio Link/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Checkout Message/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Archiving/)
    expect(rendered).to match(/false/)
  end
end
