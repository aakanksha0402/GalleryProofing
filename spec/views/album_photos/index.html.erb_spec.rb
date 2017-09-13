require 'rails_helper'

RSpec.describe "album_photos/index", type: :view do
  before(:each) do
    assign(:album_photos, [
      AlbumPhoto.create!(
        :album => nil
      ),
      AlbumPhoto.create!(
        :album => nil
      )
    ])
  end

  it "renders a list of album_photos" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
