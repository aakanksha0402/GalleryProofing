require 'rails_helper'

RSpec.describe "gallery_photos/new", type: :view do
  before(:each) do
    assign(:gallery_photo, GalleryPhoto.new(
      :gallery => nil
    ))
  end

  it "renders new gallery_photo form" do
    render

    assert_select "form[action=?][method=?]", gallery_photos_path, "post" do

      assert_select "input#gallery_photo_gallery_id[name=?]", "gallery_photo[gallery_id]"
    end
  end
end
