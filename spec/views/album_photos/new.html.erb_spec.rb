require 'rails_helper'

RSpec.describe "album_photos/new", type: :view do
  before(:each) do
    assign(:album_photo, AlbumPhoto.new(
      :album => nil
    ))
  end

  it "renders new album_photo form" do
    render

    assert_select "form[action=?][method=?]", album_photos_path, "post" do

      assert_select "input#album_photo_album_id[name=?]", "album_photo[album_id]"
    end
  end
end
