require 'rails_helper'

RSpec.describe "gallery_photos/show", type: :view do
  before(:each) do
    @gallery_photo = assign(:gallery_photo, GalleryPhoto.create!(
      :gallery => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
