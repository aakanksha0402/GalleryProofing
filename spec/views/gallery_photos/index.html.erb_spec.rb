require 'rails_helper'

RSpec.describe "gallery_photos/index", type: :view do
  before(:each) do
    assign(:gallery_photos, [
      GalleryPhoto.create!(
        :gallery => nil
      ),
      GalleryPhoto.create!(
        :gallery => nil
      )
    ])
  end

  it "renders a list of gallery_photos" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
